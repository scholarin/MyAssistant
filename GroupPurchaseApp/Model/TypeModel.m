//
//  TypeModel.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel


- (NSArray *)getData{
    NSString *fileURL = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:fileURL];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dic in array){
        [mutableArray addObject:[self modelDictionary:dic]];
    }
    
    return mutableArray;
}

-(TypeModel *)modelDictionary:(NSDictionary *)dic{
    TypeModel *typeModel = [[TypeModel alloc]init];
    typeModel.name              = dic[@"name"];
    typeModel.icon              = dic[@"icon"];
    typeModel.highlighted_icon  = dic[@"highlighted_icon"];
    typeModel.small_icon        = dic[@"small_icon"];
    typeModel.small_highlighted_icon = dic[@"small_highlighted_icon"];
    typeModel.subcategories     = dic[@"subcategories"];
    
    return typeModel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
