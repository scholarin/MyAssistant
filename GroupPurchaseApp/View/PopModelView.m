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
@property (assign ,nonatomic,readwrite) NSInteger selectedRow;

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
        rows = [self.dataSource numberOfRowsInLeftPopModelView:self];

    }else{
        NSArray *array = [self.dataSource arrayWithRightPopModelView:self];
        rows = array.count;
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
        cell.textLabel.text = [self.dataSource textOfCellForPopModelView:self atRow:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if([self.dataSource respondsToSelector:@selector(imageOfCellForPopModelView:atRow:)]){
            cell.imageView.image = [UIImage imageNamed:[self.dataSource imageOfCellForPopModelView:self atRow:indexPath.row]];
        }
        if([self.dataSource respondsToSelector:@selector(hasSubcategoriesForPopModelView:atRow:)]){
            BOOL hasSubcategories = [self.dataSource hasSubcategoriesForPopModelView:self atRow:indexPath.row];
            if(hasSubcategories){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
       
    }else{
        NSArray *array = [self.dataSource arrayWithRightPopModelView:self];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = array[indexPath.row];
    }
    return cell;
    
}

#pragma  mark - delegate




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.leftTableView){
        self.selectedRow = indexPath.row;
        [self.rightTableView reloadData];
        //判断代理是否响应此方法
        if([self.delegate respondsToSelector:@selector(didSelectedLeftPopModelView:atRow:)]){
            [self.delegate didSelectedLeftPopModelView:self atRow:indexPath.row];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(didSelectedRightPopModelView:atRow:)]){
            [self.delegate didSelectedRightPopModelView:self atRow:indexPath.row];
        }
    }
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if(tableView == self.leftTableView){
//        self.typeModel = self.typeModelArray[indexPath.row];
//        cell.imageView.image = [UIImage imageNamed: self.typeModel.small_highlighted_icon];
//    }
//}
@end
