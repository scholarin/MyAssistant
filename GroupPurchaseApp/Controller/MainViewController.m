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


@interface MainViewController (){
    UIBarButtonItem *_typeItem;
    UIBarButtonItem *_addressItem;
    UIBarButtonItem *_priorityItem;
}

@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    [self addNavigationBarItems];
}


//加载最顶端的几个Item
- (void)addNavigationBarItems{
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    MainBarButtonItem *typeItemView = [MainBarButtonItem shareButtonItem];
    [typeItemView addTarget:self action:@selector(typeItemClick)];
    _typeItem = [[UIBarButtonItem alloc]initWithCustomView:typeItemView];
    
    MainBarButtonItem *addressItemView = [MainBarButtonItem shareButtonItem];
    [addressItemView addTarget:self action:@selector(addressItemClick)];
    _addressItem = [[UIBarButtonItem alloc]initWithCustomView:addressItemView];
    
    MainBarButtonItem *priorityItemView = [MainBarButtonItem shareButtonItem];
    [priorityItemView addTarget:self action:@selector(priorityItemClick)];
    _priorityItem = [[UIBarButtonItem alloc]initWithCustomView:priorityItemView];
    
    self.navigationItem.leftBarButtonItems = @[imageItem,_typeItem,_addressItem,_priorityItem];
}

- (void)typeItemClick{
    
    TypePopViewController *controller = [[TypePopViewController alloc]init];
    UIPopoverController *popController = [[UIPopoverController alloc]initWithContentViewController:controller];
    
    [popController presentPopoverFromBarButtonItem:_typeItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }

- (void)addressItemClick{
    AddressPopViewController *addPop = [[AddressPopViewController alloc]init];
    
    UIPopoverController *addressPopController = [[UIPopoverController alloc]initWithContentViewController:addPop];
    [addressPopController presentPopoverFromBarButtonItem:_addressItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    NSLog(@"2");
}

- (void)priorityItemClick{
    NSLog(@"3");
}

- (instancetype)init{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
