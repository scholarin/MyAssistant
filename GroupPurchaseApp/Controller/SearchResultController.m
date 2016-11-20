//
//  SearchResultController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/19.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SearchResultController.h"
#import "CitiesModel.h"

@interface SearchResultController ()
{
    NSArray *_citiesArray;
}
@property (strong, nonatomic)NSArray *searchedArray;
@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSearchText:(NSString *)searchText{
    _searchText = [searchText lowercaseString];
    if(!_citiesArray){
        _citiesArray = [CitiesModel getCities];
    }
    NSMutableArray *searchedMutableArray = [[NSMutableArray alloc]init];
    for(CitiesModel *cities  in _citiesArray){
        if([cities.name containsString:_searchText] || [cities.pinYin containsString:_searchText] || [cities.pinYinHead containsString:_searchText]){
            [searchedMutableArray addObject:cities];
        }
    }
    _searchedArray = searchedMutableArray;
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"searchedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CitiesModel *citiesModel = [[CitiesModel alloc]init];
    citiesModel = self.searchedArray[indexPath.row];
    cell.textLabel.text = citiesModel.name;
    return cell;
}

#pragma  mark - tableViewdelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *city = cell.textLabel.text;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeAddress"
                                                       object:nil
                                                     userInfo:@{@"city":city}];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
