//
//  CommidityCollectionViewCell.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/20.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CommidityCollectionViewCell.h"
#import "CommodityInformationData.h"
#import "UIImageView+WebCache.h"
@interface CommidityCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *discribeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;






@end
@implementation CommidityCollectionViewCell

- (void)setCommodityWithModel:(CommodityInformationData *)CommodityInformationData{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:CommodityInformationData.s_image_url]];
    self.titleLabel.text        = CommodityInformationData.title;
    self.discribeLabel.text     = CommodityInformationData.describe;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@",CommodityInformationData.current_price];
    self.listPriceLabel.text    = CommodityInformationData.list_price;
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%@份", CommodityInformationData.purchase_count];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    // Initialization code
}

@end
