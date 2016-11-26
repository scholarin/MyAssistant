//
//  JokeTextModel.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/25.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject
@property (copy,nonatomic) NSString *jokeContent;
@property (copy,nonatomic) NSString *updataTime;
@property (copy,nonatomic) NSString *hashId;
@property (copy,nonatomic) NSString *imageURL;
+ (NSArray *)getJokeContents:(id)data;
@end
