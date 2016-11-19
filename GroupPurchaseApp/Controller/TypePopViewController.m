//
//  PopViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TypePopViewController.h"
#import "PopModelView.h"
#import "TypeModel.h"
@interface TypePopViewController ()

@end

@implementation TypePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PopModelView *popModelView = [PopModelView makePopView];
    TypeModel *typeModel = [[TypeModel alloc]init];
    popModelView.typeModelArray = [typeModel getData];
    
    //根据父视图自动调整缩放的属性，如果设置为YES，很可能不显示
    popModelView.autoresizingMask = NO;
    [self.view addSubview:popModelView];
    
    //设置当前view的preferred值，适应popView；
    self.preferredContentSize = CGSizeMake(popModelView.frame.size.width,popModelView.frame.size.height);
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
