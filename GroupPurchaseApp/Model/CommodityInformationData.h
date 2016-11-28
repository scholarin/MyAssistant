//
//  commodityInformationData.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/20.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityInformationData : NSObject
@property (copy,nonatomic) NSString* title;
@property (copy,nonatomic) NSString* city;
@property (copy,nonatomic) NSString* h5_url;
@property (copy,nonatomic) NSString* current_price;
@property (copy,nonatomic) NSString* list_price;
@property (copy,nonatomic) NSString* s_image_url;
@property (copy,nonatomic) NSString* image_url;
@property (copy,nonatomic) NSString* purchase_count;
@property (copy,nonatomic) NSString* purchase_deadline;
@property (copy,nonatomic) NSString* describe;

+(NSArray *)getCommodityDataWithResult:(NSDictionary *)result;
@end
