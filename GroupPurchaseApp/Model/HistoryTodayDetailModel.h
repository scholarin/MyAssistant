//
//  HistoryTodayDetailModel.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryTodayDetailModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;
@property (copy,nonatomic) NSString *picImage;
+ (instancetype)getHistoryTodayDetailModel:(id)data;
@end
