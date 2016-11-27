//
//  HeaderImageCell.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/27.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "HeaderImageCell.h"
#import "GroupPurchaseAppHeader.h"
@implementation HeaderImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image  = [UIImage imageNamed:@"header.gif"];
        [self addSubview: imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.width.height.equalTo(@80);
        }];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"Mosin Nagant";
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(imageView.mas_right).offset(10);
        }];
        
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.text = @"一个眼中只有代码的人";
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.equalTo(nameLabel.mas_bottom).offset(10);
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
