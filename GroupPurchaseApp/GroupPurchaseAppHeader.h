//
//  GroupPurchaseAppHeader.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/25.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#ifndef GroupPurchaseAppHeader_h
#define GroupPurchaseAppHeader_h
#import <UIKit/UIKit.h>

#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kLightGreenColor [UIColor colorWithRed:51/255.0 green:204/255.0 blue:204/255.0 alpha:1]


#define kJokeTextAPI @"http://japi.juhe.cn/joke/content/text.from?key=b579b784b12121dd43a719e8004f5d66&pagesize=20"
/*
 *大小不一，长宽比例不一，还不能通过URL来判断它加载够的尺寸，不用了 哎！
 */
#define KJokeImageAPI @"http://japi.juhe.cn/joke/img/text.from?key=b579b784b12121dd43a719e8004f5d66&pagesize=14"
#define kNewsAPI @"http://v.juhe.cn/toutiao/index?key=1d70b9c59dce9850825db4e924fa322d"
#define kTodayInHistoryAPI @"http://v.juhe.cn/todayOnhistory/queryEvent.php?key=53192f6c02892070fca01d765511ed35&pagesize=20"
#define kWechatDataAPI @"http://v.juhe.cn/weixin/query?key=7def2b3e51706c529e51f16d6a443560"
#define KHistoryTodayDetailAPI @"http://v.juhe.cn/todayOnhistory/queryDetail.php?key=53192f6c02892070fca01d765511ed35"
#endif /* GroupPurchaseAppHeader_h */
