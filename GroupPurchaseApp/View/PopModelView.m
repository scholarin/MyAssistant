//
//  popView.m
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "PopModelView.h"
#import "TypeModel.h"
@interface PopModelView() <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong ,nonatomic)TypeModel *typeModel;
@property (assign ,nonatomic)NSInteger selectedLeftRow;

@end
@implementation PopModelView

+ (PopModelView *)makePopView{
    return [[[NSBundle mainBundle]loadNibNamed:@"PopModelView" owner:self options:nil]firstObject];
}

#pragma  mark - datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rows;
    if(tableView == self.leftTableView){
        rows = self.typeModelArray.count;

    }else{
        self.typeModel = self.typeModelArray[self.selectedLeftRow];
        rows = self.typeModel.subcategories.count;
        
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if(tableView == self.leftTableView){
        self.typeModel = self.typeModelArray[indexPath.row];
        cell.textLabel.text = self.typeModel.name;
        cell.imageView.image = [UIImage imageNamed: self.typeModel.small_highlighted_icon];
        //当为左侧第一行时不能被选中
        if(indexPath.row == 0 ){
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(self.typeModel.subcategories.count > 0){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
       
    }else{
        self.typeModel = self.typeModelArray[self.selectedLeftRow];
        cell.textLabel.text = self.typeModel.subcategories[indexPath.row];
    }
    return cell;
    
}

#pragma  mark - delegate




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(tableView == self.leftTableView){
           self.typeModel = self.typeModelArray[indexPath.row];
    //选中情况下改变其图片
    cell.imageView.image = [UIImage imageNamed:self.typeModel.small_icon];
    self.selectedLeftRow = indexPath.row;
            [self.rightTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(tableView == self.leftTableView){
        self.typeModel = self.typeModelArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed: self.typeModel.small_highlighted_icon];
    }
}
@end
