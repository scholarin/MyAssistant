//
//  MeViewController.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/27.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#define kHeaderCell @"HeaderImageCell"



#import "GroupPurchaseAppHeader.h"
#import "MeViewController.h"
#import "HeaderImageCell.h"


@interface MeViewController ()
@end

@implementation MeViewController{
    NSArray *_cellContents;
    NSDictionary *_infoDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HeaderImageCell class] forCellReuseIdentifier:kHeaderCell] ;
    _cellContents = @[@[@"二维码",@"收藏夹"],
                      @[@"清理缓存",@"关于我"]];
    _infoDic = @{ @"email"  : @"scholarinfarm@gmail.com",
                  @"wechat" : @"sneaker1101"};
    
    self.tableView.scrollEnabled = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count;
    if(section == 0){
        count = 1;
    }else if(section == 1){
        count = 4;
    }else{
        count = 2;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;

    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCell forIndexPath:indexPath];
    }else if(indexPath.section == 1){
        if(indexPath.row < 2){
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
            }
            
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            if(indexPath.row == 0){
                cell.detailTextLabel.text = [_infoDic objectForKey:@"wechat"];
                cell.textLabel.text = @"微信号";
            }else{
                cell.detailTextLabel.text = [_infoDic objectForKey:@"email"];
                cell.textLabel.text = @"电子邮箱";
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            }
            cell.textLabel.text = _cellContents[indexPath.section - 1][indexPath.row-2];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
            }
            cell.textLabel.text = _cellContents[indexPath.section - 1][indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [self getCacheSizeToString];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            }
            cell.textLabel.text = _cellContents[indexPath.section - 1][indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    }
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if(indexPath.section == 0){
        height = 100;
    }else{
        height = 30;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat footerHeight;
    if(section == 2) {
        footerHeight = kScreen_Height - 64 - 15 * 3 - 100 - 30 * 6 - 49;
    }
    return footerHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.section == 0 || (indexPath.section == 1 && indexPath.row < 2)){
        indexPath = nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 2){
            UIViewController *VC = [[UIViewController alloc]init];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:kScreen_Bounds];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.contentMode = UIViewContentModeTop;
            imageView.image = [UIImage imageNamed:@"QRcode"];
            [VC.view addSubview:imageView];
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            UIViewController *VC = [[UIViewController alloc]init];
            VC.view.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:15];
            label.text = @"您的收藏夹空空如也！";
            label.textAlignment = NSTextAlignmentCenter;
            [VC.view addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(VC.view).offset(kScreen_Height/4);
                make.height.equalTo(@40);
                make.left.right.equalTo(VC.view);
            }];
            [self.navigationController pushViewController:VC animated:YES];
            self.navigationController.navigationBar.backItem.title = self.title;
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            [self showClearAlertController];
        }else{
        UIViewController *VC = [[UIViewController alloc]init];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:kScreen_Bounds];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:@"profile"];
        [VC.view addSubview:imageView];
        [self.navigationController pushViewController:VC animated:YES];
        }
    }
    
}


- (void)showClearAlertController{
    UIAlertController *alertConroller = [UIAlertController alertControllerWithTitle:@"缓存有助于再次浏览或离线查看，你确定要清除缓存么？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定清除"
                                                          style: UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf clearChache];
    }];
    UIAlertAction *laertAction = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [alertConroller addAction:alertAction];
    [alertConroller addAction:laertAction];
    [self presentViewController:alertConroller animated:YES completion:nil];
}


- (void)clearChache{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"正在清除缓存中……" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
        [self.tableView reloadData];

    }];
}


- (NSString *)getCacheSizeToString{
    
    NSString *string = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0];

    return string;
}


@end
