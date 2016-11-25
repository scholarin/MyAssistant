//
//  AdvertisingColumn.m
//  CustomTabBar
//
//  Created by shikee_app05 on 14-12-30.
//  Copyright (c) 2014年 chan kaching. All rights reserved.
//

#import "AdvertisingColumn.h"
@interface AdvertisingColumn()<UIScrollViewDelegate>{
    NSTimer *_timer;
}
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *imageNum;
@property (nonatomic) NSInteger totalNum;
@end
@implementation AdvertisingColumn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _scrollView.backgroundColor = [UIColor purpleColor];
        _scrollView.delegate = self;//设置代理UIscrollViewDelegate
        _scrollView.showsVerticalScrollIndicator = NO;//是否显示竖向滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;//是否显示横向滚动条
        _scrollView.pagingEnabled = YES;//是否设置分页
        
        [self addSubview:_scrollView];

        /*
         ***容器，装载
         */
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-20, CGRectGetWidth(self.frame), 20)];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame))];
        alphaView.backgroundColor = [UIColor orangeColor];
        alphaView.alpha = 0.7;
        [containerView addSubview:alphaView];
        
        //分页控制
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(containerView.frame)-20, 20)];
        _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _pageControl.currentPage = 0;
        
        [containerView addSubview:_pageControl];
        //图片张数
        _imageNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(containerView.frame)-20, 20)];
        _imageNum.font = [UIFont boldSystemFontOfSize:15];
        _imageNum.backgroundColor = [UIColor clearColor];
        _imageNum.textColor = [UIColor whiteColor];
        _imageNum.textAlignment = NSTextAlignmentRight;
        [containerView addSubview:_imageNum];
        /*
         ***配置定时器，自动滚动广告栏
         */
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    }
    return self;
}
//-------------------------------------------------------------------------------------------

-(void)timerAction:(NSTimer *)timer{
    if (_totalNum>1) {
        CGPoint newOffset = _scrollView.contentOffset;
        newOffset.x = newOffset.x + CGRectGetWidth(_scrollView.frame);
        
        if (newOffset.x > (CGRectGetWidth(_scrollView.frame) * (_totalNum-1))) {
            newOffset.x = 0 ;
        }
        int index = newOffset.x / CGRectGetWidth(_scrollView.frame);   //当前是第几个视图
        newOffset.x = index * CGRectGetWidth(_scrollView.frame);
        _imageNum.text = [NSString stringWithFormat:@"%d / %ld",index+1,_totalNum];
        [_scrollView setContentOffset:newOffset animated:YES];
    }else{
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    }
}

#pragma mark- PageControl绑定ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
        _pageControl.currentPage = index;
        for (UIView *view in scrollView.subviews) {
            if(view.tag == index){
                
            }else{
                
            }
        }
    }

}
- (void)setArray:(NSArray *)imgArray{
    _totalNum = [imgArray count];
    if (_totalNum>0) {
        for (int i = 0; i<_totalNum; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.image = [UIImage imageNamed:imgArray[i]];
            //img.backgroundColor = imgArray[i];
            [img setTag:i];
            [_scrollView addSubview:img];
        }
        _imageNum.text = [NSString stringWithFormat:@"%ld / %ld",_pageControl.currentPage+1,_totalNum];
        _pageControl.numberOfPages = _totalNum; //设置页数 //滚动范围 600=300*2，分2页
        CGRect frame;
        frame = _pageControl.frame;
        frame.size.width = 15*_totalNum;
        _pageControl.frame = frame;
    }else{
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [img setImage:[UIImage imageNamed:@"comment_gray"]];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        _imageNum.text = @"提示：滚动栏无数据。";
    }
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*_totalNum,CGRectGetHeight(_scrollView.frame));//滚动范围 600=300*2，分2页
}
- (void)openTimer{
    [_timer setFireDate:[NSDate distantPast]];//开启定时器
}
- (void)closeTimer{
    [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
