//
//  HistoryTodayModel.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryTodayModel : NSObject
@property (copy,nonatomic) NSString *date;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *eventID;
+ (NSArray *)getHistoryTodayContent:(id)data;
@end
