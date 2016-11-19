//
//  CitiesModel.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CitiesModel.h"

@implementation CitiesModel
+ (NSArray *)getCities{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"cities" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *citiesArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in array){
        CitiesModel *cities = [[CitiesModel alloc]init];
        cities.name         = dic[@"name"];
        cities.pinYin       = dic[@"pinYin"];
        cities.pinYinHead   = dic[@"pinYinHead"];
        cities.regions      = dic[@"regions"];
        [citiesArray addObject:cities];
    }
    return citiesArray;
}
@end
