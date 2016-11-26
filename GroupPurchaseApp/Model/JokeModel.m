//
//  JokeTextModel.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/25.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "JokeModel.h"

@implementation JokeModel
+ (NSArray *)getJokeContents:(id)data{
    NSDictionary *resultDic = data[@"result"];
    NSMutableArray *jokeTexts = [NSMutableArray new];
    NSArray *array = resultDic[@"data"];
    for(NSDictionary *dataDic in array){
        JokeModel *jokeTextModel = [[JokeModel alloc]init];
        jokeTextModel.hashId = dataDic[@"hashId"];
        //处理返回的自负穿里面有中文全交空格的问题
        NSString *string    = dataDic[@"content"];
        NSString *string1   = [string stringByReplacingOccurrencesOfString:@"　　" withString:@"\n　　"];
        NSString *string2   = @"　　";
        
        jokeTextModel.jokeContent   = [string2 stringByAppendingString:string1];
        jokeTextModel.updataTime    = dataDic[@"updatetime"];
        jokeTextModel.imageURL      = dataDic[@"url"];
        [jokeTexts addObject:jokeTextModel];
        //NSLog(@"%@,%@,%@",jokeTextModel.hashId,jokeTextModel.jokeContent,jokeTextModel.updataTime);
    }
    return jokeTexts;
}



@end
