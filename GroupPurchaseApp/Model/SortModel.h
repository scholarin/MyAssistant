//
//  SortModel.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/21.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortModel : NSObject
@property (copy,nonatomic) NSString* sortWay;
@property (assign, nonatomic) NSInteger value;

+(NSArray *)getSortData;
@end
