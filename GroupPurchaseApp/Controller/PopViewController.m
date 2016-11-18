//
//  PopViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "PopViewController.h"
#import "PopModelView.h"
#import "TypeModel.h"
@interface PopViewController ()

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PopModelView *popModelView = [PopModelView makePopView];
    TypeModel *typeModel = [[TypeModel alloc]init];
    popModelView.typeModelArray = [typeModel getData];
    popModelView.autoresizingMask = NO;
    [self.view addSubview:popModelView];
    NSLog(@"%f,%f,%f,%f",self.view.bounds.origin.x,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
    
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
