//
//  popView.h
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopModelView : UIView
@property (strong ,nonatomic) NSArray *typeModelArray;

+ (PopModelView*)makePopView;

@end
