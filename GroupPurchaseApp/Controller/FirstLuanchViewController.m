//
//  FirstLuanchViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/23.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kFitstLuanchImage @"LaunchImage"

#import "FirstLuanchViewController.h"
#import "Masonry.h"
#import "MainNavigationController.h"
#import "MainVCViewController.h"

@interface FirstLuanchViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControll;
@property (assign, nonatomic)NSInteger pageNumer;
@property (strong, nonatomic)UIButton *startButton;
@end

@implementation FirstLuanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"hasBeingStart"];
    self.pageNumer = 4;
    [self commidInit];
    [self loadScrollVieW];
   
    
    // Do any additional setup after loading the view.
}

- (void)commidInit{
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = self.view.frame;
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView;
    });
    
    _pageControll = [[UIPageControl alloc]init];
    _pageControll.numberOfPages = self.pageNumer;
    _pageControll.center = CGPointMake(kScreen_Width/2, kScreen_Height - 70);
    _pageControll.pageIndicatorTintColor = [UIColor grayColor];
    _pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControll.currentPage = 0;
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControll];
    
    _startButton = [UIButton new];
    _startButton.center = CGPointMake(kScreen_Width / 2, kScreen_Height - 10);
    CGFloat buttonHeight = 30;
    CGFloat buttonWidth = 100;
    _startButton.frame = CGRectMake((kScreen_Width - buttonWidth)/2,kScreen_Height-20-buttonHeight,buttonWidth,buttonHeight);
    
    
    UIColor *color = [UIColor colorWithRed:169/255.0 green:177/255.0 blue:135/255.0 alpha:1.0];
    _startButton.backgroundColor = [UIColor clearColor];
    [_startButton setTitle:@"我想知道⇢" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _startButton.layer.cornerRadius = buttonHeight /2;
    _startButton.layer.borderWidth = 1.0;
    _startButton.layer.borderColor = color.CGColor;
    _startButton.hidden = YES;
   // _startButton.backgroundColor = [UIColor yellowColor];
    [_startButton addTarget:self action:@selector(goMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
    
}


- (void)loadScrollVieW{
    for(int i = 0 ; i < self.pageNumer ; i++){
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake( i*kScreen_Width,0,kScreen_Width,kScreen_Height);
        imageView.image = [UIImage imageNamed: kFitstLuanchImage];
        [self.scrollView addSubview:imageView];
        if(i == 0){
            UILabel *label = [[UILabel alloc]init];
            label.text = @"        鲁滨逊第四次航海时，船在途中遇到风暴触礁，船上水手、乘客等全部遇难，唯有鲁滨逊幸存，只身漂流到一个杳无人烟的孤岛上。此时他面临着人生的三大难题……";
            label.numberOfLines = 0;
            [imageView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView).with.offset(30);
                make.right.equalTo(imageView).with.offset(-30);
                make.top.equalTo(@(imageView.center.y));
            }];
        }else{
            UILabel *label = [[UILabel alloc]init];
            if(i == 1){
                label.text = @"以后吃什么？";
            }else if(i == 2){
                label.text = @"以后看什么？";
            }else{
                label.text = @"以后干什么？";
            }
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:30];
            
            [imageView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(imageView);
                make.width.equalTo(@30);
                make.center.equalTo(imageView);
            }];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.pageNumer * kScreen_Width, kScreen_Height);
}



- (void)goMainView{
    
    MainVCViewController *mainVC = [[MainVCViewController alloc]init];
    MainNavigationController *mainNotVC = [[MainNavigationController alloc]initWithRootViewController:mainVC];
    [self presentViewController:mainNotVC animated:YES completion:nil];
    NSLog(@"BUTTON可以点击");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / kScreen_Width;
    
    self.pageControll.currentPage = page;
    if(self.pageControll.currentPage == self.pageNumer - 1){
        self.startButton.hidden = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
