//
//  ChangeCityViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "CityGroupsModel.h"
#import "SearchResultController.h"
#import "UIView+AutoLayout.h"

@interface ChangeCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SearchResultControllerDelegate>
@property (strong, nonatomic)NSArray *CityGroupArray;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)SearchResultController *searchResultVC;
@end

@implementation ChangeCityViewController{
    CityGroupsModel *_cityGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close_hl"] style:UIBarButtonItemStyleDone target:self action:@selector(backToAddressVC)];
    self.navigationItem.leftBarButtonItem = item;
    
    _cityGroup = [[CityGroupsModel alloc]init];
    self.CityGroupArray = [_cityGroup getCityGroups];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isDismiss:) name:@"changeAddress" object:nil];
}


- (void)backToAddressVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)isDismiss:(NSNotification *)not{
    self.isDismiss = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.isDismiss == YES){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//lazying load
- (SearchResultController *)searchResultVC{
    if(!_searchResultVC ){
        _searchResultVC = [[SearchResultController alloc]init];
        _searchResultVC.delegate = self;
        [self.view addSubview:_searchResultVC.view];
        
        //UIView+AutoLayout 库中的函数 设置其和父视图或者兄弟视图的间距
        [_searchResultVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [_searchResultVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:5];
    }
    return _searchResultVC;
}
#pragma  mark - tableViewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.CityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _cityGroup = self.CityGroupArray[section];
    
    return _cityGroup.groupCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    _cityGroup = self.CityGroupArray[indexPath.section];
    cell.textLabel.text = _cityGroup.groupCitys[indexPath.row];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    _cityGroup = self.CityGroupArray[section];
    return _cityGroup.grouptitle;
}


//选中后获取cell的text值并发送通知
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *city = cell.textLabel.text ;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeAddress"
                                                       object:nil
                                                     userInfo:@{@"city":city}];

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark - searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.coverView.hidden = NO;
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.coverView.hidden = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length > 0){
        self.searchResultVC.view.hidden = NO;
        self.searchResultVC.searchText = searchText;
        self.coverView.hidden = NO;
    }else{
        self.searchResultVC.view.hidden = YES;
        self.coverView.hidden = YES;
    }
}


- (void)dismissSearchResultControllSuperView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
