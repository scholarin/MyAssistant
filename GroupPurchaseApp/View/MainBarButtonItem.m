//
//  MainBarButtonItem.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/18.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainBarButtonItem.h"



@interface MainBarButtonItem ()
//@property (weak, nonatomic) IBOutlet UIButton *barButtonItem;
//@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
//@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonItem;

@end
@implementation MainBarButtonItem

+(instancetype)shareButtonItem{
    return [[[NSBundle mainBundle]loadNibNamed:@"MainBarButtonItem" owner:self options:nil]firstObject];
}

- (void)addTarget:(id)target action:(SEL)action{
    [self.buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
//尝试使用类方法直接展示Item的各小图标
//- (instancetype)initWithImageName:(NSString *)imageName andMainString:(NSString *)string andSubString:(NSString *)subString{
//    if (self = [super init]){
//        self = [[[NSBundle mainBundle]loadNibNamed:@"MainBarButtonItem" owner:self options:nil]firstObject];
//        self.barButtonItem.imageView.image = [UIImage imageNamed:imageName];
//        self.mainLabel.text = string;
//        self.subLabel.text = subString;
//    }
//    return self;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
