//
//  JokeTextCell.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/25.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "JokeTextCell.h"
#import "UILabel+Height.h"

@interface JokeTextCell ()
@property(strong, nonatomic)UILabel *jokeTextLabel;
@end
@implementation JokeTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
     
        self.jokeTextLabel = [[UILabel alloc]init];
        self.jokeTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.jokeTextLabel.numberOfLines = 0;
        self.jokeTextLabel.font = [UIFont systemFontOfSize:15];
        //self.jokeTextLabel.text = self.jokeText;
        [self addSubview:self.jokeTextLabel];
        
        [self.jokeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 40, 0, 40));
        }];
    }
    return self;
}


- (void)layoutSubviews{
    self.jokeTextLabel.text = self.jokeText;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
