//
//  NewsModel.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *date;
@property (copy,nonatomic) NSString *dataSource;
@property (copy,nonatomic) NSString *pic_320;
@property (copy,nonatomic) NSString *pic_550;
@property (copy,nonatomic) NSString *URL;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *realType;


+ (NSArray *)getNews:(id)data;
@end
