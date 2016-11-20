//
//  AddressPopViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "AddressPopViewController.h"
#import "ChangeCityViewController.h"
#import "MainNavigationController.h"
#import "CitiesModel.h"
#import "PopModelView.h"

@interface AddressPopViewController ()<PopModelViewDataSource,PopModelViewDelegate>
@property (strong, nonatomic) PopModelView *addressPopModelView;
@property (strong, nonatomic) NSArray *citiesArray;
@end

@implementation AddressPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressPopModelView = [PopModelView makePopView];
    self.addressPopModelView.dataSource = self;
    self.addressPopModelView.delegate = self;
    self.addressPopModelView.autoresizingMask = NO;
    self.addressPopModelView.frame = CGRectMake(0, 44, 320, 400);
    [self.view addSubview: self.addressPopModelView];
    
    self.preferredContentSize = CGSizeMake(self.addressPopModelView.frame.size.width, self.addressPopModelView.frame.size.height);
    self.citiesArray = [CitiesModel getCities];
    NSLog(@"%@",self.addressPopModelView);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeCity:(UIButton *)sender {
    ChangeCityViewController *changeCityVc = [[ChangeCityViewController alloc]init];
    MainNavigationController* nav = [[MainNavigationController alloc]initWithRootViewController:changeCityVc];
    
    //模态动画
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    //弹视出一个NAV
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma  mark - popmodel view datasource
- (NSInteger)numberOfRowsInLeftPopModelView:(PopModelView *)popModelView{
    NSLog(@"调用了mei");
    return self.citiesArray.count;
}
- (NSString *)textOfCellForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row{
    CitiesModel *cities = self.citiesArray[row];
    return cities.name;
}
- (NSArray *)arrayWithRightPopModelView:(PopModelView *)popModelView{
    CitiesModel *cities = self.citiesArray[popModelView.selectedRow];
    NSArray *regions = cities.regions;
    return  regions;
}

- (BOOL)hasSubcategoriesForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row{
    BOOL hasSub = NO;
    CitiesModel *cities = self.citiesArray[row];
    if(cities.regions.count > 0){
        hasSub = YES;
    }
    return hasSub;
}

#pragma mark - popmodel view delegate


- (void)didSelectedRightPopModelView:(PopModelView *)popModelView atRow:(NSUInteger)row{
    CitiesModel *cities = self.citiesArray[popModelView.selectedRow];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeRegion"
                                                       object:nil
                                                     userInfo:@{@"address":cities.name ,@"region":cities.regions[row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
