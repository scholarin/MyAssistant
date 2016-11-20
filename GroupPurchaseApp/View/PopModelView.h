//
//  popView.h
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopModelView;
@protocol PopModelViewDataSource <NSObject>
@optional
- (NSInteger)numberOfRowsInLeftPopModelView:(PopModelView *)popModelView;
- (NSString *)textOfCellForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row;
- (NSString *)imageOfCellForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row;
- (NSArray *)arrayWithRightPopModelView:(PopModelView *)popModelView ;
- (BOOL)hasSubcategoriesForPopModelView:(PopModelView *)popModelView atRow:(NSInteger)row;
@end

@protocol PopModelViewDelegate <NSObject>
@optional
- (void)didSelectedLeftPopModelView:(PopModelView *)popModelView atRow:(NSUInteger)row;
- (void)didSelectedRightPopModelView:(PopModelView *)popModelView atRow:(NSUInteger)row;

@end

@interface PopModelView : UIView
@property (strong ,nonatomic) NSArray *typeModelArray;
@property (assign ,nonatomic) id<PopModelViewDataSource> dataSource;
@property (assign ,nonatomic) id<PopModelViewDelegate> delegate;
@property (assign ,nonatomic,readonly) NSInteger selectedRow;

+ (PopModelView*)makePopView;

@end
