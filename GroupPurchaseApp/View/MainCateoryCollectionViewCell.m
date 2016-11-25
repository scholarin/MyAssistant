//
//  MainCateoryCollectionViewCell.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/23.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainCateoryCollectionViewCell.h"
@interface MainCateoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
@implementation MainCateoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCollectionCellwithImage:(NSString *)image title:(NSString *)title{
    self.categoryImage.image = [UIImage imageNamed:image];
    self.categoryLabel.text = title;
}
@end
