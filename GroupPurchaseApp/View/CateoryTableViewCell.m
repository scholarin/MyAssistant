//
//  CateoryTableViewCell.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CateoryTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommodityInformationData.h"

@interface CateoryTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *commodityImageView;
@property (weak, nonatomic) IBOutlet UILabel *commodityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityCurrentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityListPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityPurchaseCountLabel;


@end
@implementation CateoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setCommodityData:(CommodityInformationData *)commodityData{
    [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString: commodityData.image_url ]];
    self.commodityTitleLabel.text = commodityData.title;
    self.commodityDetailLabel.text = commodityData.describe;
    self.commodityCurrentPriceLabel.text = [NSString stringWithFormat:@"¥%@",commodityData.current_price];
    self.commodityListPriceLabel.text = commodityData.list_price;
    self.commodityPurchaseCountLabel.text = [NSString stringWithFormat:@"已售：%@份", commodityData.purchase_count];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
