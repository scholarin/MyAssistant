//
//  JokeImageCell.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "JokeImageCell.h"

@interface JokeImageCell()
@property (strong,nonatomic)UILabel *imageTitleLabel;
@property (strong,nonatomic)UIImageView *jokeImageView;

@end
@implementation JokeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.imageTitleLabel = [[UILabel alloc]init];
        self.imageTitleLabel.font = [UIFont systemFontOfSize:10];
        self.imageTitleLabel.textColor = [UIColor lightGrayColor];
        self.imageTitleLabel.numberOfLines = 1;
        
        [self addSubview:self.imageTitleLabel];
        
        [self.imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self);
        }];
        
        self.jokeImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            //imageView.contentMode = UIViewContentModeCenter;
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.top.equalTo(self.imageTitleLabel.mas_bottom).offset(5);
                make.bottom.equalTo(self);
            }];
            imageView;
        });
    }
    return self;
}

- (void)layoutSubviews{
    self.imageTitleLabel.text = self.imageTitle;
    [self.jokeImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
