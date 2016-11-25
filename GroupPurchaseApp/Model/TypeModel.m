//
//  TypeModel.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel


+ (NSArray *)getData{
    TypeModel *typeModel = [[TypeModel alloc]init];
    NSArray *plistData = [typeModel getPlistData];
    NSMutableArray *data = [NSMutableArray new];
    for(NSDictionary *dic in plistData){
        TypeModel *typeModel = [[TypeModel alloc]init];
        typeModel.name              = dic[@"name"];
        typeModel.icon              = dic[@"icon"];
        typeModel.highlighted_icon  = dic[@"highlighted_icon"];
        typeModel.small_icon        = dic[@"small_icon"];
        typeModel.small_highlighted_icon = dic[@"small_highlighted_icon"];
        typeModel.subcategories     = dic[@"subcategories"];
        [data addObject:typeModel];
    }
    return data;
}


+ (NSArray *)getCategoryUseCollectionCell{
    TypeModel *typeModel = [[TypeModel alloc]init];
    NSArray *plistData = [typeModel getPlistData];
    NSMutableArray *categorys = [NSMutableArray new];
    for(int i = 0 ; i < 8 ; i++ ){
        NSDictionary *dic = plistData[i];
        NSDictionary *cateGoryDic = [[NSDictionary alloc]initWithObjectsAndKeys:dic[@"name"], @"name",dic[@"highlighted_icon"],@"icon",nil];
        [categorys addObject:cateGoryDic];
    }
    return categorys;
}

- (NSArray *)getPlistData{
    NSString *fileURL = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:fileURL];
    return array;
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
