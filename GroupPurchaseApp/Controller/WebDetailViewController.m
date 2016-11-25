//
//  WebDetailViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/24.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width;
#define kScreenHeight [UIScreen mainScreen].bounds.size.height;
#import "WebDetailViewController.h"
#import "Masonry.h"
@interface WebDetailViewController ()
@property (strong, nonatomic)UIWebView *webView;
@end

@implementation WebDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.h5_url]];
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view.
}


- (void)updateUI{
    
    UIBarButtonItem *goBackItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_highlighted"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = goBackItem;
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.webView];
    
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.right.equalTo(self.view).offset(-20);
//    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
