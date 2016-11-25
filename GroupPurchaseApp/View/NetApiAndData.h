//
//  NetApiAndData.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityInformationData.h"

@interface NetApiAndData : NSObject

- (void)request_CommditiesWith:(NSDictionary *)dict andBlcok:(void (^)(NSArray *commditiesListArray, NSError *error))block;
@end
