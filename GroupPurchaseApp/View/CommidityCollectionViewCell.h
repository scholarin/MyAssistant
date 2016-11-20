//
//  CommidityCollectionViewCell.h
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/20.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommodityInformationData;
@interface CommidityCollectionViewCell : UICollectionViewCell
- (void)setCommodityWithModel:(CommodityInformationData *)CommodityInformationData;
@end
