//
//  SortTableViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/21.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SortTableView.h"
#import "SortModel.h"
#import "Masonry.h"
#import "BlocksKit+UIKit.h"

@interface SortTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *sortModelArray;
@property (strong, nonatomic) UITableView *sortTableView;
@property (strong, nonatomic) UIView *contentView, *headView, *footView;
@end

@implementation SortTableView


- (instancetype)init{
    if(self = [super init]){
        
        self.frame = [UIScreen mainScreen].bounds;
        self.sortModelArray = [SortModel getSortData];
        //if(!_contentView){
            //_contentView = [UIView new];
            //_contentView.backgroundColor = [UIColor blackColor];
           // _contentView.alpha = 0.3;
            //_contentView.alpha = 0.5;
            //[self addSubview:_contentView];
//            [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self);
//            }];
        
            if(!_headView){
                _headView =({
                    UIView *headView = [[UIView alloc]init];
                    [headView bk_whenTapped:^{
                        [self doDismiss];
                    }];
                    headView;
                });
                    [self addSubview:_headView];
                    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.right.equalTo(self);
                        make.height.equalTo(@64);
                }];
                
            }
            
            if(!_sortTableView){
                _sortTableView = ({
                    UITableView *tableview = [[UITableView alloc]init];
                    tableview.backgroundColor = [UIColor whiteColor];
                    tableview.alpha = 1;
                    tableview.dataSource = self;
                    tableview.delegate = self;
                    tableview;
                });
                [self addSubview:_sortTableView];
                [_sortTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.equalTo(self);
                    make.top.equalTo(_headView.mas_bottom);
                    make.height.equalTo(@280);
                }];
                
            }
            
            if(!_footView){
                _footView = ({
                    UIView *footView = [[UIView alloc]init];
                    [footView bk_whenTapped:^{
                        [self doDismiss];
                    }];
                    footView;
                });
                [self addSubview:_footView];
                [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.left.right.equalTo(self);
                    make.top.equalTo(_sortTableView.mas_bottom);
                }];
                
            }
        
        NSLog(@"%@",self.sortModelArray);
    }
    return self;
}

+ (instancetype)shareInstance{
    static SortTableView *sortView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sortView = [[self alloc]init];
    });
    return sortView;
}
+ (void)showShareSortView{
    [[SortTableView shareInstance]showShareView];
}

- (void)showShareView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    NSLog(@"%@",self);
    //d动画效果
    //CGPoint endCenter = self.center;
    //NSLog(@"这里的CENTER 是%f,%f",endCenter.x,endCenter.y);
    //endCenter.y -= CGRectGetHeight(self.frame);
    // NSLog(@",这里的CenterWei %f",endCenter.y);
    //[UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    // self.center = CGPointMake(187.5, 600);
    //} completion:nil];
}

- (void)doDismiss{
//    CGPoint endCenter = self.center;
//    endCenter.y += CGRectGetHeight(self.frame);
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//       self.center = endCenter;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    [self removeFromSuperview];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sortModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]init];
    }
    SortModel *sortModel = [[SortModel alloc]init];
    sortModel = self.sortModelArray[indexPath.row];
    cell.textLabel.text = sortModel.sortWay;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    // Configure the cell...
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SortModel *sortModel = [[SortModel alloc]init];
    sortModel = self.sortModelArray[indexPath.row];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sortChange"
                                                       object:nil
                                                     userInfo:@{@"sort" : [NSNumber numberWithInteger:sortModel.value],
                                                            @"sortWay" : sortModel.sortWay}];
    [self doDismiss];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
@end
