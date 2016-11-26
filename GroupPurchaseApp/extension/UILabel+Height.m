//
//  UILabel+Height.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UILabel+Height.h"

@implementation UILabel (Height)
+ (CGFloat)labelHeightWithString:(NSString *)string{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(kScreen_Width - 40, MAXFLOAT)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil].size;
    return contentSize.height;
}
@end
