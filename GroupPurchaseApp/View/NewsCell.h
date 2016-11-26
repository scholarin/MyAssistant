//
//  NewsCell.h
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsCell : UITableViewCell
- (void)setNewContent:(NewsModel *)newsModel;
@end
