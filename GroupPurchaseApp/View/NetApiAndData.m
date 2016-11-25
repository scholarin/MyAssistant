//
//  NetApiAndData.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NetApiAndData.h"
#import "DPAPI.h"

@interface NetApiAndData()<DPRequestDelegate>
@property(strong, nonatomic)NSArray *commoditiesListArray;

@end


@implementation NetApiAndData
- (void)request_CommditiesWith:(NSDictionary *)dict andBlcok:(void (^)(NSArray *array, NSError *error))block{
    [DPRequest requestWithURL:@"v1/deal/find_deals" params:dict delegate:self];
}



#pragma mark - DPRequestDelegate

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"网络请求出现错误，错误代码 %@",error);
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    self.commoditiesListArray = [CommodityInformationData getCommodityDataWithResult:result];
}
@end
