//
//  NewsCell.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NewsCell.h"
#import "GroupPurchaseAppHeader.h"
#import "NewsModel.h"
@interface NewsCell()
@property (strong, nonatomic)  UILabel *dataSourceLabel;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *typeLabel;
@property (strong, nonatomic)  UILabel *dateLabel;
@property (strong, nonatomic)  UIImageView *imageNewsView;


@end
@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.dataSourceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(5);
                make.left.equalTo(self).offset(40);
                make.height.equalTo(@20);
            }];
            label;
        });
        
        self.imageNewsView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.dataSourceLabel.mas_bottom).offset(5);
                make.height.equalTo(@240);
            }];
            imageView;
        });
        
        self.dateLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentRight;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-20);
                make.height.equalTo(@20);
                make.bottom.equalTo(self).offset(-10);
            }];
            label;
        });
        
        self.typeLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.height.equalTo(@20);
                make.bottom.equalTo(self).offset(-10);
            }];
            label;
        });
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.numberOfLines = 2;
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.bottom.equalTo(self.typeLabel.mas_top).offset(-10);
            }];
            label;
        });
    }
    return self;
}
- (void)setNewContent:(NewsModel *)newsModel{
    self.dataSourceLabel.text = newsModel.dataSource;
    self.titleLabel.text = newsModel.title;
    self.typeLabel.text = [NSString stringWithFormat:@"%@:%@",newsModel.type,newsModel.realType];
    self.dateLabel.text = newsModel.date;
    [self.imageNewsView sd_setImageWithURL:[NSURL URLWithString:newsModel.pic_320]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
