//
//  NewsModel.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
+ (NSArray *)getNews:(id)data{
    
    NSMutableArray *news = [NSMutableArray new];
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultDic = (NSDictionary *)data[@"result"];
        NSArray *dataArray = resultDic[@"data"];
        for(NSDictionary *dic in dataArray){
            NewsModel *new = [[NewsModel alloc]init];
            new.title       = dic[@"title"];
            new.date        = dic[@"date"];
            new.dataSource  = dic[@"author_name"];
            new.pic_320     = dic[@"thumbnail_pic_s"];
            new.pic_550     = dic[@"thumbnail_pic_s02"];
            new.URL         = dic[@"url"];
            new.type        = dic[@"type"];
            new.realType    = dic[@"realtype"];
            [news addObject:new];
        }
    }
    return news;
}





//"reason":"成功的返回",
//"result":{
//    "stat":"1",
//    "data":[
//            {
//                "title":"上海“黄金大劫案”，折损中共多名干将，毛泽东耿耿于怀18年",
//                "date":"2016-11-26 06:49",
//                "author_name":"国家人文历史",
//                "thumbnail_pic_s":"http:\/\/07.imgmini.eastday.com\/mobile\/20161126\/20161126064915_6c57856e0f2280f73404eafe67c6bc1c_1_mwpm_03200403.jpeg",
//                "thumbnail_pic_s02":"http:\/\/07.imgmini.eastday.com\/mobile\/20161126\/20161126064915_6c57856e0f2280f73404eafe67c6bc1c_1_mwpl_05500201.jpeg",
//                "thumbnail_pic_s03":"http:\/\/07.imgmini.eastday.com\/mobile\/20161126\/20161126064915_6c57856e0f2280f73404eafe67c6bc1c_1_mwpl_05500201.jpeg",
//                "url":"http:\/\/mini.eastday.com\/mobile\/161126064915731.html?qid=juheshuju",
//                "uniquekey":"161126064915731",
//                "type":"头条",
//                "realtype":"历史"
//            },
@end
