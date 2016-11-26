//
//  HistoryTodayModel.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "HistoryTodayModel.h"

@implementation HistoryTodayModel
+ (NSArray *)getHistoryTodayContent:(id)data{
    NSMutableArray *history = [NSMutableArray new];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *historyData = data[@"result"];
        for(NSDictionary *dic in historyData){
            HistoryTodayModel *historyTodayModel = [[HistoryTodayModel alloc]init];
            historyTodayModel.title = dic[@"title"];
            historyTodayModel.date = dic[@"date"];
            historyTodayModel.eventID = dic[@"e_id"];
            [history addObject:historyTodayModel];
        }
    }
    return history;
}
@end
//"reason":"success",
//"result":[
//          {
//              "day":"11\/26",
//              "date":"1504年11月26日",
//              "title":"西班牙女王伊莎贝尔一世逝世",
//              "e_id":"13204"
//          },
