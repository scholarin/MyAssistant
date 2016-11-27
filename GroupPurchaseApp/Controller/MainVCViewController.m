//
//  MainVCViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/23.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainVCViewController.h"
#import "MainCateoryCollectionViewCell.h"
#import "CateoryTableViewCell.h"
#import "TypeModel.h"

#import "MainBarButtonItem.h"
#import "TypePopViewController.h"
#import "AddressPopViewController.h"
#import "SortTableView.h"

#import "DPAPI.h"
#import "CommodityInformationData.h"
#import "CommodityDetailViewController.h"

#import "Masonry.h"
#import "SDImageCache.h"

#define kLightGreenColor [UIColor colorWithRed:51/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCategoryCell @"MainCateoryCollectionViewCell"
#define kCommoditiesListCell @"CateoryTableViewCell"

@interface MainVCViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource, DPRequestDelegate>
@property (strong, nonatomic) UICollectionView *categoryCollectionView;
@property (strong, nonatomic) NSArray *cateorysForCollectionCell;

@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableDictionary *requestParamsDict;
@property (strong, nonatomic) NSMutableArray *commoditiesListArray;

@property (assign, nonatomic) BOOL isLoadMore;
@end

@implementation MainVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCollectionView];
    [self showCommoditiesListCell];
    
    [self addNavigationBarItems];
    [self addOBserver];
    [self creatRequest];
    
    
    NSString *pate = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",pate);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)showCollectionView{
    if(!_categoryCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _categoryCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) collectionViewLayout:layout];
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 20);
        layout.itemSize = CGSizeMake(50, 70);
        layout.minimumLineSpacing = (kScreenWidth - 4 * 50)/5;
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(20, (kScreenWidth - 4 * 50)/5, 20, (kScreenWidth - 4 * 50)/5);
        
        [_categoryCollectionView registerNib:[UINib nibWithNibName:kCategoryCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCategoryCell];
        [_categoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableView"];
        
        _categoryCollectionView.delegate = self;
        _categoryCollectionView.dataSource = self;
        _categoryCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _categoryCollectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_categoryCollectionView];
    }
}

- (void)showCommoditiesListCell{
    if(!_listTableView){
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        //_listTableView.tableHeaderView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [_listTableView registerNib:[UINib nibWithNibName:kCommoditiesListCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCommoditiesListCell];
        _listTableView.backgroundColor = [UIColor whiteColor];
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview: _listTableView];
    }
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.categoryCollectionView.mas_bottom);
    }];
    
    if(!_refreshControl){
        _refreshControl = [[UIRefreshControl alloc]init];
        _refreshControl.tintColor = [UIColor colorWithRed:51/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉显示分类"];
        [_refreshControl addTarget:self action:@selector(updateLoad) forControlEvents:UIControlEventValueChanged];
    }
    
    //[_listTableView addSubview:_refreshControl];
}

//下拉显示CollectionVeiw
- (void)updateLoad{
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.categoryCollectionView.center = CGPointMake(kScreenWidth/2 , self.categoryCollectionView.bounds.size.height/2);
    } completion:nil];

        [self.refreshControl endRefreshing];
    [self.refreshControl removeFromSuperview];
}

//加载更多
- (void)loadMore{
    self.isLoadMore = YES;
    int page = [self.requestParamsDict[@"page"] intValue];
    page ++;
    [self.requestParamsDict setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [self creatRequest];
}

- (NSArray *)cateorysForCollectionCell{
    if(!_cateorysForCollectionCell){
        _cateorysForCollectionCell = [TypeModel getCategoryUseCollectionCell];
    }
    return _cateorysForCollectionCell;
}

- (NSMutableArray *)commoditiesListArray{
    if(!_commoditiesListArray){
        _commoditiesListArray = [NSMutableArray new];
    }
    return _commoditiesListArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - navigationControllerItem
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
    [priorityItemView addTarget:self action:@selector(sortItemClick)];
    UIBarButtonItem *priorityItem = [[UIBarButtonItem alloc]initWithCustomView:priorityItemView];
    
    self.navigationItem.leftBarButtonItems = @[imageItem,typeItem,addressItem,priorityItem];
    self.navigationController.navigationBar.autoresizingMask = NO;
}

//顶端item 弹出事件
- (void)typeItemClick{
    
    TypePopViewController *controller = [[TypePopViewController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[1];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)addressItemClick{
    
    AddressPopViewController *addPop = [[AddressPopViewController alloc]init];
    addPop.modalPresentationStyle = UIModalPresentationPopover;
    addPop.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[2];
    [self presentViewController:addPop animated:YES completion:nil];
}

- (void)sortItemClick{
    [SortTableView showShareSortView];
}

//根据弹出选择调整Item
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

//接收通知
#pragma  mark - 注册通知及通知后的响应事件
- (void)addOBserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryChange:) name:@"changeCategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(typeChange:) name:@"changeType" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addressChange:) name:@"changeAddress" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionChange:) name:@"changeRegion" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortChange:) name:@"sortChange" object:nil];
}

- (void)categoryChange:(NSNotification *)not{
    NSString *category = not.userInfo[@"category"];
    [self.requestParamsDict setObject:category forKey:@"category"];
    [self.requestParamsDict setObject:@1 forKey:@"page"];
    //更改BarbuttonItem文字
    [self replaceBarButtonItemTitle:category subTitle:@"全部" target:@selector(typeItemClick) atIndex:1 ];
    [self creatRequest];
    
}
- (void)typeChange:(NSNotification *)not{
    NSString *category = not.userInfo[@"category"];
    NSString *type = not.userInfo[@"type"];
    if([type isEqualToString:@"全部"]){
        [self.requestParamsDict setObject:category forKey:@"category"];
    }else{
        [self.requestParamsDict setObject:type forKey:@"category"];
    }
    [self.requestParamsDict setObject:@1 forKey:@"page"];
    //更改Item文字
    [self replaceBarButtonItemTitle:category subTitle:type target:@selector(typeItemClick) atIndex:1];
    [self creatRequest];
    
    
}

- (void)addressChange:(NSNotification *)not{
    NSString *address = not.userInfo[@"city"];
    [self.requestParamsDict setObject:address forKey:@"city"];
    [self.requestParamsDict setObject:@1 forKey:@"page"];
    [self replaceBarButtonItemTitle:@"坐标" subTitle:address target:@selector(addressItemClick) atIndex:2];
    [self creatRequest];
    
    
}

- (void)regionChange:(NSNotification *)not{
    NSString *address = not.userInfo[@"address"];
    NSString *region = not.userInfo[@"region"];
    [self.requestParamsDict setObject:address forKey:@"city"];
    [self.requestParamsDict setObject:@1 forKey:@"page"];
    [self replaceBarButtonItemTitle:address subTitle:region target:@selector(addressItemClick) atIndex:2];
    [self creatRequest];
    
}

- (void)sortChange:(NSNotification *)not{
    NSString *sortWay = not.userInfo[@"sortWay"];
    [self.requestParamsDict setObject:not.userInfo[@"sort"] forKey:@"sort"];
    [self.requestParamsDict setObject:@1 forKey:@"page"];
    [self replaceBarButtonItemTitle:@"排序" subTitle:sortWay target:@selector(sortItemClick) atIndex:3];
    [self creatRequest];
}

#pragma mark - networking

- (void)creatRequest{
    
    DPAPI *api = [[DPAPI alloc]init];
    [api requestWithURL:@"v1/deal/find_deals" params:self.requestParamsDict delegate:self];
    NSLog(@"%@%@",self.requestParamsDict[@"category"],self.requestParamsDict[@"city"]);
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    if(self.isLoadMore){
        [self.commoditiesListArray addObjectsFromArray:[CommodityInformationData getCommodityDataWithResult:result]];
    }else{
        self.commoditiesListArray = [[CommodityInformationData getCommodityDataWithResult:result] mutableCopy];
    }
    self.isLoadMore = NO;
    [self.listTableView reloadData];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"网络请求出现错误，错误代码 %@",error);
}

- (NSDictionary *)requestParamsDict{
    if(!_requestParamsDict){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *dic = @{@"category"  : @"美食",
                               @"city"      : @"北京",
                               @"sort"      : @1,
                               @"page"      : @1,};
        _requestParamsDict = [dic mutableCopy];
        });
    }
    return _requestParamsDict;
}

#pragma  mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    MainCateoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryCell forIndexPath:indexPath];
    
    NSDictionary *cateGoryDic = self.cateorysForCollectionCell[indexPath.item];
    [cell setCollectionCellwithImage:cateGoryDic[@"icon"] title:cateGoryDic[@"name"]];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter                      withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    label.text = @"- 猜你喜欢 -";
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [footerview addSubview:view];
    return footerview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == 0){
        [self.requestParamsDict removeObjectForKey:@"category"];
    }else{
        [self.requestParamsDict setObject:self.cateorysForCollectionCell[indexPath.item][@"name"] forKey:@"category"];
    }
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.categoryCollectionView.center = CGPointMake(kScreenWidth/2, - self.categoryCollectionView.frame.size.height/2);
    } completion:nil];
    [self.listTableView addSubview:self.refreshControl];
    [self creatRequest];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commoditiesListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CateoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommoditiesListCell];
    [cell setCommodityData:self.commoditiesListArray[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    label.text = @"  推荐商家";
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = kLightGreenColor;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor lightGrayColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [button setTitle:@"------ 点击加载更多 ------" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:button];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityDetailViewController *vc = [[CommodityDetailViewController alloc]init];
    vc.dataModel = self.commoditiesListArray[indexPath.row];

    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
