//
//  LineThrough.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/20.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LineThrough.h"

@implementation LineThrough


- (void)drawRect:(CGRect)rect {
    [super drawRect: rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2);
    CGContextStrokePath(context);
}


@end
