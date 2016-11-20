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
@interface TypePopViewController ()<PopModelViewDataSource,PopModelViewDelegate>{
    TypeModel *_typeModel;
}
@property (strong, nonatomic)NSArray *typeArray;
@property (strong, nonatomic)PopModelView *popModelView;
@end

@implementation TypePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
   
    _typeModel = [[TypeModel alloc]init];
    _typeArray =[_typeModel getData];
    //根据父视图自动调整缩放的属性，如果设置为YES，很可能不显示
    self.popModelView = [PopModelView makePopView];
    self.popModelView.autoresizingMask = NO;
    self.popModelView.dataSource = self;
    self.popModelView.delegate = self;
    [self.view addSubview:self.popModelView];
    
    //设置当前view的preferred值，适应popView；
    self.preferredContentSize = CGSizeMake(self.popModelView.frame.size.width,self.popModelView.frame.size.height);
     //Do any additional setup after loading the view.
}

//- (NSArray *)typeArray{
//    if(!_typeArray){
//        _typeArray =[_typeModel getData];
//    }
//    return _typeArray;
//}

#pragma  mark - popModelView dataSource
- (NSInteger)numberOfRowsInLeftPopModelView:(PopModelView *)popModelView{
    return _typeArray.count;
}
- (NSString *)textOfCellForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row{
    _typeModel = _typeArray[row];
    return _typeModel.name;
}

- (NSString *)imageOfCellForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row{
    return [_typeArray[row] small_highlighted_icon];
}

- (NSArray *)arrayWithRightPopModelView:(PopModelView *)popModelView{
    _typeModel = _typeArray[popModelView.selectedRow];
    
    return _typeModel.subcategories;
}

- (BOOL)hasSubcategoriesForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row{
    _typeModel = _typeArray[row];
    if(_typeModel.subcategories.count > 0){
        return YES;
    }
    return NO;
}


#pragma  mark - popModelView delegate
- (void)didSelectedLeftPopModelView:(PopModelView *)popModelView atRow:(NSUInteger)row{
    _typeModel = _typeArray[row];
    if(!_typeModel.subcategories.count){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCategory"
                                                           object:nil
                                                         userInfo:@{@"category":_typeModel.name}];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}

- (void)didSelectedRightPopModelView:(PopModelView *)popModelView atRow:(NSUInteger)row{
    _typeModel = _typeArray[popModelView.selectedRow];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeType"
                                                       object:nil
                                                     userInfo:@{@"type"     : _typeModel.subcategories[row],
                                                                @"category" : _typeModel.name }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
