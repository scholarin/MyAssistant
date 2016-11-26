//
//  NetApiAndData.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NetApiAndData.h"
#import "GroupPurchaseAppHeader.h"

@interface NetApiAndData()
@property(strong, nonatomic)NSArray *newsTypeArray;
@end


@implementation NetApiAndData

//笑话的网路请求封装
- (void)requestJokeContentWithPage:(NSInteger)page returnData:(void (^)(id, NSError *))responseObject{
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [self requestURLString:kJokeTextAPI parameters:dic returnData:^(id data, NSError *error) {
        responseObject(data,error);
    }];
    
}

//新闻的网络请求封装
- (void)requestNewsContentWithType:(NSInteger)typeNuber returnData:(void (^)(id, NSError *))responseObject{
    NSDictionary *parameterDic = @{@"type" : [NSNumber numberWithInteger:typeNuber]};
    [self requestURLString:kNewsAPI parameters:parameterDic returnData:^(id data, NSError *error) {
        responseObject(data,error);
    }];
}

//微信精选的网络请求封装
- (void)requestWechatContentWithType:(NSInteger)pageNumber returnData:(void (^)(id, NSError *))responseObject{
    NSDictionary *parameters = @{@"pno" : [NSNumber numberWithInteger:pageNumber]};
    [self requestURLString:kWechatDataAPI parameters:parameters returnData:^(id data, NSError *error) {
        responseObject(data,error);
    }];
}

//历史上的今天
- (void)requestHistoryTodayContentWithDate:(NSString *)date returnData:(void (^)(id, NSError *))responseObject{
    NSDictionary *dic = @{@"date" : date};
    [self requestURLString:kTodayInHistoryAPI parameters:dic returnData:^(id data, NSError *error) {
        responseObject(data,error);
    }];
}

//历史上的今天详情
- (void)requestHistoryTodayDetailWithID:(NSString *)ID returnData:(void (^)(id, NSError *))responseObject{
    NSDictionary *parameters = @{@"e_id" : ID};
    [self requestURLString:KHistoryTodayDetailAPI parameters:parameters returnData:^(id data, NSError *error) {
        responseObject(data,error);
    }];
}



//通用的网络请求方法 以后工程变大时候可以提炼
- (void)requestURLString:(NSString *)URLString parameters:(id)parameters returnData:(void (^)(id , NSError *))returnData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        returnData(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        returnData(nil,error);
    }];
}

- (NSArray *)newsTypeArray{
    return @[@"top",@"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang"];
}

+ (instancetype)shareManager{
    return [[self alloc]init];
}
@end

