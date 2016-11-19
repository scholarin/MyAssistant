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
#import "CityGroupsModel.h"
@interface AddressPopViewController ()

@end

@implementation AddressPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CityGroupsModel *cityGroup = [[CityGroupsModel alloc]init];
    NSArray* array = [cityGroup getCityGroups];
    for(CityGroupsModel *cG in array){
        NSLog(@"%@",cG.grouptitle);
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
