//
//  MianViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/18.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainViewController.h"
#import "MainBarButtonItem.h"
#import "TypePopViewController.h"
#import "AddressPopViewController.h"
#import "DPAPI.h"
#import "CommodityInformationData.h"
#import "CommidityCollectionViewCell.h"
#import "MJRefresh.h"
#import "CommodityDetailViewController.h"

@interface MainViewController ()<DPRequestDelegate>{

}
@property (strong, nonatomic)NSMutableDictionary *requestDict;
@property (strong, nonatomic)NSArray *commodityDataArray;
@property (strong, nonatomic)UIRefreshControl *refresh;
@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"CommidityCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //下拉继续加载数据
    self.refresh = [[UIRefreshControl alloc]init];
    self.refresh.tintColor = [UIColor redColor];
    self.refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"继续加载数据"];
    [self.refresh addTarget:self action:@selector(uploadData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refresh];
    
    
    // Register cell classes
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommidityCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    
    [self addNavigationBarItems];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryChange:) name:@"changeCategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(typeChange:) name:@"changeType" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addressChange:) name:@"changeAddress" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionChange:) name:@"changeRegion" object:nil];

    self.collectionView.alwaysBounceVertical = YES;
    
    [self createURLRequest];
}

- (void)uploadData{
    int page = [self.requestDict[@"page"] intValue];
    page ++;
    [self.requestDict setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [self createURLRequest];
    
}
//单例的请求字典
- (NSMutableDictionary *)requestDict{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestDict = [[NSMutableDictionary alloc]init];
        [_requestDict setObject:@"美食" forKey:@"category"];
        [_requestDict setObject:@"上海" forKey:@"city"];
        [_requestDict setObject:@1 forKey:@"sort"];
        [_requestDict setObject:@1 forKey:@"page"];
    });
    return _requestDict;
}

#pragma  mark - nsnotification 响应
//通知响应方法
- (void)categoryChange:(NSNotification *)not{
    NSString *category = not.userInfo[@"category"];
    [self.requestDict setObject:category forKey:@"category"];
    [self.requestDict setObject:@1 forKey:@"page"];
    //更改BarbuttonItem文字
    [self replaceBarButtonItemTitle:category subTitle:@"全部" target:@selector(typeItemClick) atIndex:1 ];
    [self createURLRequest];
}
- (void)typeChange:(NSNotification *)not{
    NSString *category = not.userInfo[@"category"];
    NSString *type = not.userInfo[@"type"];
    if([type isEqualToString:@"全部"]){
        [self.requestDict setObject:category forKey:@"category"];
    }else{
        [self.requestDict setObject:type forKey:@"category"];
    }
    [self.requestDict setObject:@1 forKey:@"page"];
    //更改Item文字
    [self replaceBarButtonItemTitle:category subTitle:type target:@selector(typeItemClick) atIndex:1];
    [self createURLRequest];
}

- (void)addressChange:(NSNotification *)not{
    NSString *address = not.userInfo[@"city"];
    [self.requestDict setObject:address forKey:@"city"];
    [self.requestDict setObject:@1 forKey:@"page"];
    [self replaceBarButtonItemTitle:@"坐标" subTitle:address target:@selector(addressItemClick) atIndex:2];
    [self createURLRequest];
    NSLog(@"%@",address);
}

- (void)regionChange:(NSNotification *)not{
    NSString *address = not.userInfo[@"address"];
    NSString *region = not.userInfo[@"region"];
    [self.requestDict setObject:address forKey:@"city"];
    [self.requestDict setObject:@1 forKey:@"page"];
    [self replaceBarButtonItemTitle:address subTitle:region target:@selector(addressItemClick) atIndex:2];
    [self createURLRequest];
}
//创建网络请求
- (void)createURLRequest{
    
    DPAPI *api = [[DPAPI alloc]init];
    [api requestWithURL:@"v1/deal/find_deals" params:self.requestDict delegate:self];
    NSLog(@"地址 = %@ ，分类 = %@" ,self.requestDict[@"city"],self.requestDict[@"category"]);
}

#pragma  mark - 顶端item创建
//加载最顶端的几个Item
- (void)addNavigationBarItems{
     UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    imageItem.enabled = NO;
    
    MainBarButtonItem *typeItemView = [MainBarButtonItem shareButtonItem];
    [typeItemView addTarget:self action:@selector(typeItemClick)];
    UIBarButtonItem *typeItem = [[UIBarButtonItem alloc]initWithCustomView:typeItemView];
    
    MainBarButtonItem *addressItemView = [MainBarButtonItem shareButtonItem];
    addressItemView.cateoryLabel.text = @"北京";
    addressItemView.typeLabel.text = @"朝阳区";
    [addressItemView addTarget:self action:@selector(addressItemClick)];
    UIBarButtonItem *addressItem = [[UIBarButtonItem alloc]initWithCustomView:addressItemView];
    
    MainBarButtonItem *priorityItemView = [MainBarButtonItem shareButtonItem];
    priorityItemView.cateoryLabel.text = @"排序";
    priorityItemView.typeLabel.text = @"默认";
    [priorityItemView addTarget:self action:@selector(priorityItemClick)];
    UIBarButtonItem *priorityItem = [[UIBarButtonItem alloc]initWithCustomView:priorityItemView];
    
    self.navigationItem.leftBarButtonItems = @[imageItem,typeItem,addressItem,priorityItem];
    self.navigationController.navigationBar.autoresizingMask = NO;
}


//根据选择更改顶部Item标题

- (void)replaceBarButtonItemTitle:(NSString *)title subTitle:(NSString *)subTitle target:(SEL)target atIndex:(NSInteger)index{
    MainBarButtonItem *replaceItemView = [MainBarButtonItem shareButtonItem];
    replaceItemView.cateoryLabel.text = title;
    replaceItemView.typeLabel.text = subTitle;
    [replaceItemView addTarget:self action:target];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:replaceItemView];
    //self.navigationItem.leftBarButtonItems = @[_imageItem,_typeItem,_addressItem,_priorityItem];
    NSMutableArray *mutableArray = [self.navigationItem.leftBarButtonItems mutableCopy];
    [mutableArray replaceObjectAtIndex:index withObject:item];
    self.navigationItem.leftBarButtonItems = mutableArray;
    
}
//顶端item 弹出事件
- (void)typeItemClick{
    
    TypePopViewController *controller = [[TypePopViewController alloc]init];
    UIPopoverController *popController = [[UIPopoverController alloc]initWithContentViewController:controller];
    [popController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItems[1] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
 }

- (void)addressItemClick{
    
    AddressPopViewController *addPop = [[AddressPopViewController alloc]init];
    UIPopoverController *addressPopController = [[UIPopoverController alloc]initWithContentViewController:addPop];
    [addressPopController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItems[2] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    NSLog(@"2");
}

- (void)priorityItemClick{
    NSLog(@"3");
}

#pragma  mark - 初始化

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(300, 300);
    
    //通过加载进来时的主界面数据计算inset 和 minimum line spacing
    int needless = (int)[UIScreen mainScreen].bounds.size.width % 300;
    int number = (int)[UIScreen mainScreen].bounds.size.width / 300;
    CGFloat inset = needless / (number + 1) ;
    layout.sectionInset  = UIEdgeInsetsMake(20, inset, 20, inset);
    layout.minimumLineSpacing = inset;
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    //通过屏幕旋转后的size 计算 inset 和 minimum line spacing
    int needless = (int)size.width % 300;
    int number = (int)size.width / 300;
    NSLog(@"%d ,%d",needless,number);
    CGFloat inset = needless / (number + 1) ;
    layout.sectionInset  = UIEdgeInsetsMake(20, inset, 20, inset);
    layout.minimumLineSpacing = inset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DPrequest delegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    //NSLog(@"%@",result);
    self.commodityDataArray = [CommodityInformationData getCommodityDataWithResult:(NSDictionary *)result];
    //NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@ -%@ -%@ -%@",dataModel.title,dataModel.city,dataModel.h5_url,dataModel.current_price,dataModel.list_price,dataModel.s_image_url,dataModel.image_url,dataModel.purchase_count,dataModel.purchase_deadline,dataModel.describe);
    [self.collectionView reloadData];
    [self.refresh endRefreshing];
    NSLog(@"更新数据");
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{

    NSLog(@"%@",error);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    return self.commodityDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CommidityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setCommodityWithModel:self.commodityDataArray[indexPath.item]];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CommodityDetailViewController *vc = [[CommodityDetailViewController alloc]init];
    vc.dataModel = self.commodityDataArray[indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
