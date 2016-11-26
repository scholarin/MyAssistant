//
//  RootViewController.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/27.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "RootViewController.h"
#import "MainNavigationController.h"
#import "MainVCViewController.h"
#import "NewsViewController.h"
#import "MeViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainVCViewController *mainVC = [[MainVCViewController alloc]init];
    MainNavigationController *mainNav = [[MainNavigationController alloc]initWithRootViewController:mainVC];
    mainNav.tabBarItem.title = @"主页";
    mainNav.tabBarItem.image = [UIImage imageNamed:@"home"];
    
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    MainNavigationController *newsNav = [[MainNavigationController alloc]initWithRootViewController:newsVC];
    newsNav.tabBarItem.title = @"资讯";
    newsNav.tabBarItem.image = [UIImage imageNamed:@"newspaper"];
    
    MeViewController *meVC = [[MeViewController alloc]init];
    MainNavigationController *meNav = [[MainNavigationController alloc]initWithRootViewController:meVC];
    meNav.tabBarItem.title = @"我的";
    meNav.tabBarItem.image = [UIImage imageNamed:@"user"];
    
    self.viewControllers = @[mainNav,newsNav,meNav];
    // Do any additional setup after loading the view.
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

@end
