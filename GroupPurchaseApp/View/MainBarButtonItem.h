//
//  MainBarButtonItem.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/18.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainBarButtonItem : UIView
@property (weak, nonatomic) IBOutlet UILabel *cateoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
+(instancetype)shareButtonItem;

- (void)addTarget:(id)target action:(SEL)action;
- (void)setCateory:(NSString *)cateory type:(NSString *)type;
@end
