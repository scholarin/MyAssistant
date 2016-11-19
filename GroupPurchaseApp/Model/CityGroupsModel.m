//
//  CityGroupsModel.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CityGroupsModel.h"

@interface CityGroupsModel()

@property(strong,nonatomic)NSArray *loadCityArray;

@end


@implementation CityGroupsModel

- (void)loadCityGroupsData{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"cityGroups" ofType:@"plist"];
    self.loadCityArray = [NSArray arrayWithContentsOfFile:filePath];
}

- (NSArray *)getCityGroups{
    [self loadCityGroupsData];
    NSMutableArray *cityGroupsArray = [[NSMutableArray alloc]init];
    for(NSDictionary* dic in self.loadCityArray){
        CityGroupsModel *cityGroup = [[CityGroupsModel alloc]init];
        cityGroup.grouptitle = dic[@"title"];
        cityGroup.groupCitys = dic[@"cities"];
        [cityGroupsArray addObject:cityGroup];
    }
    return cityGroupsArray;
}

@end
