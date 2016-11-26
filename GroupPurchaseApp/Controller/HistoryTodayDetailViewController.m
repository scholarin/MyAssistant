//
//  HistoryTodayDetailViewController.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#import "GroupPurchaseAppHeader.h"
#import "HistoryTodayDetailViewController.h"
#import "NetApiAndData.h"
#import "HistoryTodayDetailModel.h"

@interface HistoryTodayDetailViewController ()
@property (strong, nonatomic)UIImageView *picView;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UITextView *detailTextView;
@property (strong, nonatomic)HistoryTodayDetailModel *historyTodayDetailModel;
@end

@implementation HistoryTodayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showUI];
    [self requsetHistoryDetail];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)showUI{
    if(!_picView){
        _picView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [self.view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(20);
                make.left.equalTo(self.view).offset(20);
                make.right.equalTo(self.view).offset(-20);
                make.height.equalTo(@200);
            }];
            imageView;
        });
    }
    
    if(!_titleLabel){
        _titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            [self.view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_picView.mas_bottom).offset(20);
                make.left.equalTo(self.view).offset(20);
                make.right.equalTo(self.view).offset(-20);
                make.height.equalTo(@30);
            }];
            label;
        });
    }
    
    if(!_detailTextView){
        _detailTextView = ({
            UITextView *textView = [[UITextView alloc]init];
            textView.font = [UIFont systemFontOfSize:15];
            textView.showsHorizontalScrollIndicator = NO;
            textView.showsVerticalScrollIndicator = NO;
            [self.view addSubview:textView];
            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom).offset(10);
                make.left.equalTo(self.view).offset(20);
                make.right.equalTo(self.view).offset(-20);
                make.bottom.equalTo(self.view.mas_bottom);
            }];
            textView;
        });
    }
}

- (void)requsetHistoryDetail{
    NetApiAndData *net = [NetApiAndData shareManager];
    [net requestHistoryTodayDetailWithID:self.eventID returnData:^(id data, NSError *error) {
        self.historyTodayDetailModel = [HistoryTodayDetailModel getHistoryTodayDetailModel:data];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setHistoryTodayDetailModel:(HistoryTodayDetailModel *)historyTodayDetailModel{
    _historyTodayDetailModel = historyTodayDetailModel;
    _titleLabel.text = _historyTodayDetailModel.title;
    [_picView sd_setImageWithURL:[NSURL URLWithString:_historyTodayDetailModel.picImage] placeholderImage:[UIImage imageNamed:@"no_image"]];
    
    _detailTextView.text = _historyTodayDetailModel.content;
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
