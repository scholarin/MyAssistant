//
//  WechatModel.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *dataSource;
@property (copy,nonatomic) NSString *imageURL;
@property (copy,nonatomic) NSString *URL;

+ (NSArray *)getWechatData:(id)data;
@end
