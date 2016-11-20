//
//  CitiesModel.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesModel : NSObject
@property (copy,nonatomic) NSString* name;
@property (copy,nonatomic) NSString* pinYin;
@property (copy,nonatomic) NSString* pinYinHead;
@property (copy,nonatomic) NSArray * regions;
+ (NSArray *)getCities;

@end
