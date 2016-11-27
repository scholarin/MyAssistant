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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self.tableView registerClass:[HeaderImageCell class] forCellReuseIdentifier:kHeaderCell] ;
    _cellContents = @[@[@"二维码",@"收藏夹"],
                      @[@"清理缓存",@"关于我"]];
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
    }else{
        count = 2;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;

    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCell forIndexPath:indexPath];
    }else if(indexPath.section == 2 && indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        }
        cell.textLabel.text = _cellContents[indexPath.section - 1][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = [self getCacheSizeToString];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        int i = 1;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.textLabel.text = _cellContents[indexPath.section - 1][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        footerHeight = kScreen_Height - 100 - 30 *4 - 20 * 3 - 64 - 40;
    }
    return footerHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.section == 0 ){
        indexPath = nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            UIViewController *VC = [[UIViewController alloc]init];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:kScreen_Bounds];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.contentMode = UIViewContentModeTop;
            imageView.image = [UIImage imageNamed:@"QRcode.JPG"];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
