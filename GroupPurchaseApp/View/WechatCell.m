//
//  WechatCell.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#import "GroupPurchaseAppHeader.h"
#import "WechatCell.h"
#import "WechatModel.h"

@interface WechatCell()

@property (strong, nonatomic)  UILabel *dataSourceLabel;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageWechatView;
@end
@implementation WechatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
         self.titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.top.equalTo(self).offset(5);
                make.right.equalTo(self).offset(-20);
            }];
            label;
        });
        
        
        self.dataSourceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-10);
                make.right.equalTo(self).offset(-20);
            }];
            label;
        });
        
        self.imageWechatView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
                make.height.equalTo(@200);
            }];
            imageView;
        });
        
       
    }
    return self;
}

- (void)setWechatContent:(WechatModel *)model{
    self.dataSourceLabel.text = model.dataSource;
    self.titleLabel.text = model.title;
    [self.imageWechatView sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
