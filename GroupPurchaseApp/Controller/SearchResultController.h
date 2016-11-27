//
//  SearchResultController.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultController;

@protocol SearchResultControllerDelegate <NSObject>
//此方法用来在用户选择了Cell的时候让他和父视图同时消失
- (void)dismissSearchResultControllSuperView;

@end
@interface SearchResultController : UITableViewController
@property (copy,nonatomic) NSString* searchText;
@property (assign, nonatomic)id<SearchResultControllerDelegate> delegate;
@end
