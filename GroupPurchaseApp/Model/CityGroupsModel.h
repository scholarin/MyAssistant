//
//  CityGroupsModel.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroupsModel : NSObject

@property (copy,nonatomic) NSString* grouptitle;
@property (strong,nonatomic) NSArray* groupCitys;
- (NSArray *)getCityGroups;
@end
