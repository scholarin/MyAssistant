//
//  RootViewController.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/27.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#import "GroupPurchaseAppHeader.h"
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
    self.viewControllers = @[[self setMainTabBar], [self setNewTabBar],[self setMeTabar]];
    // Do any additional setup after loading the view.
}


- (MainNavigationController *)setMainTabBar{
    MainVCViewController *mainVC = [[MainVCViewController alloc]init];
    MainNavigationController *mainNav = [[MainNavigationController alloc]initWithRootViewController:mainVC];
    mainNav.tabBarItem.title = @"主页";
    [mainNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                kLightGreenColor, NSForegroundColorAttributeName,
                                                nil] forState:UIControlStateSelected];
    [mainNav.tabBarItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                                 nil] forState:UIControlStateNormal];
    mainNav.tabBarItem.badgeColor = kLightGreenColor;
    mainNav.tabBarItem.selectedImage = [UIImage imageNamed:@"home"];
    mainNav.tabBarItem.image = [UIImage imageNamed:@"height_light_home"];
    return mainNav;
}

- (MainNavigationController *)setNewTabBar{
   
    
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    MainNavigationController *newsNav = [[MainNavigationController alloc]initWithRootViewController:newsVC];
    [newsNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                kLightGreenColor, NSForegroundColorAttributeName,
                                                nil] forState:UIControlStateSelected];
    [newsNav.tabBarItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                                 nil] forState:UIControlStateNormal];
    newsNav.tabBarItem.title = @"资讯";
    newsNav.tabBarItem.selectedImage = [UIImage imageNamed:@"newspaper"];
    newsNav.tabBarItem.image = [UIImage imageNamed:@"height_light_newspaper"];
    return newsNav;
}

- (MainNavigationController *)setMeTabar{
    MeViewController *meVC = [[MeViewController alloc]init];
    MainNavigationController *meNav = [[MainNavigationController alloc]initWithRootViewController:meVC];
    [meNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                kLightGreenColor, NSForegroundColorAttributeName,
                                                nil] forState:UIControlStateSelected];
    [meNav.tabBarItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                                 nil] forState:UIControlStateNormal];
    meNav.tabBarItem.title = @"我的";
    meNav.tabBarItem.selectedImage = [UIImage imageNamed:@"user"];
    meNav.tabBarItem.image = [UIImage imageNamed:@"height_light_user"];
    return meNav;
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
