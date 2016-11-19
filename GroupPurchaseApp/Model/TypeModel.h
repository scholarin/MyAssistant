//
//  TypeModel.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeModel : UIView
@property (copy,nonatomic)  NSString *name;
@property (copy,nonatomic)  NSString *icon;
@property (copy,nonatomic)  NSString *highlighted_icon;
@property (copy,nonatomic)  NSString *small_icon;
@property (copy,nonatomic)  NSString *small_highlighted_icon;
@property (strong,nonatomic) NSArray *subcategories;

- (NSArray *)getData;
@end
