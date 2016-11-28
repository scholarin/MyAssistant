//
//  CommodityDetailViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/21.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "WebDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface CommodityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.image_url]];
    self.titleLabel.text = self.dataModel.title;
    self.describeLabel.text = self.dataModel.describe;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoiteCommodity:(id)sender {
    WebDetailViewController *webVC = [[WebDetailViewController alloc]init];
    webVC.h5_url  = self.dataModel.h5_url;
    [self.navigationController pushViewController:webVC animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_highlighted"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
//    self.navigationItem.leftBarButtonItem = item;
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"网页详情" style:UIBarButtonItemStyleDone target:self action:@selector(showDetail)] ;
//    rightItem.tintColor = [UIColor colorWithRed:51/255.0 green:204/255.0 blue:204/255.0 alpha:1];
//    self.navigationItem.rightBarButtonItem = rightItem;
//}

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
