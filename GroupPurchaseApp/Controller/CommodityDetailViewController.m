//
//  CommodityDetailViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/21.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface CommodityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.image_url]];
    self.titleLabel.text = self.dataModel.title;
    self.describeLabel.text = self.dataModel.describe;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.dataModel.h5_url]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)favoiteCommodity:(id)sender {
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
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
