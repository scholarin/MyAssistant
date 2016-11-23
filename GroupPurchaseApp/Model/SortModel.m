//
//  SortModel.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/21.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel

+ (NSArray *)getSortData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"sorts" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *sortDataArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in array){
        SortModel *sortModel = [[SortModel alloc]init];
        sortModel.sortWay = dic[@"label"];
        sortModel.value = [dic[@"value"] integerValue];
        [sortDataArray addObject:sortModel];
        
    }
    return sortDataArray;
}

@end
