//
//  WechatModel.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WechatModel.h"

@implementation WechatModel
+ (NSArray *)getWechatData:(id)data{
    NSMutableArray *wechatArray = [NSMutableArray new];
    if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *resultDic = data[@"result"];
        NSArray *list = resultDic[@"list"];
        for(NSDictionary *dic in list){
            WechatModel *wechatModel = [[WechatModel alloc]init];
            wechatModel.title = dic[@"title"];
            wechatModel.dataSource = dic[@"source"];
            wechatModel.URL = dic[@"url"];
            wechatModel.imageURL = dic[@"firstImg"];
            [wechatArray addObject:wechatModel];
        }
        
    }
    return wechatArray;
}
@end
//"reason":"success",
//"result":{
//    "list":[
//            {
//                "firstImg":"http:\/\/zxpic.gtimg.com\/infonew\/0\/wechat_pics_-8774101.jpg\/640",
//                "id":"wechat_20151202064749",
//                "source":"果果帮",
//                "title":"笑死了,哈哈小伙子你很有前途",
//                "url":"http:\/\/v.juhe.cn\/weixin\/redirect?wid=wechat_20151202064749",
//                "mark":""
//            },
