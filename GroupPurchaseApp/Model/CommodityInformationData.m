//
//  commodityInformationData.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/20.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CommodityInformationData.h"

@implementation CommodityInformationData

+ (NSArray *)getCommodityDataWithResult:(NSDictionary *)result{
    
    NSArray *array = result[@"deals"];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in array){
        CommodityInformationData *dataModel = [[CommodityInformationData alloc]init];
        dataModel.title             = dic[@"title"];
        dataModel.city              = dic[@"city"];
        dataModel.h5_url            = dic[@"deal_h5_url"];
        
        double currentPrice = [dic[@"current_price"] doubleValue];
        dataModel.current_price     = [NSString stringWithFormat:@"%.2f",currentPrice];
        dataModel.list_price        = [dic[@"list_price"] stringValue];
        dataModel.s_image_url       = dic[@"s_image_url"];
        dataModel.image_url         = dic[@"image_url"];
        dataModel.purchase_count    = [dic[@"purchase_count"] stringValue];
        dataModel.purchase_deadline = dic[@"purchase_deadline"];
        dataModel.describe          = dic[@"description"];
        [dataArray addObject:dataModel];
    }
    return dataArray;
}
@end
