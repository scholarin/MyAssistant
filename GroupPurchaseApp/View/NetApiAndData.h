//
//  NetApiAndData.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupPurchaseAppHeader.h"
#import "AFNetWorking.h"

@interface NetApiAndData : NSObject

+ (instancetype)shareManager;

- (void)requestJokeContentWithPage:(NSInteger)page returnData:(void (^)(id data, NSError *error))responseObject;
- (void)requestNewsContentWithType:(NSInteger)typeNuber returnData:(void (^)(id data, NSError *error))responseObject;
- (void)requestWechatContentWithType:(NSInteger)pageNumber returnData:(void (^)(id data, NSError *error))responseObject;
- (void)requestHistoryTodayContentWithDate:(NSString *)data returnData:(void (^)(id data, NSError *error))responseObject;
- (void)requestHistoryTodayDetailWithID:(NSString *)ID returnData:(void (^)(id data, NSError *error))responseObject;
@end
