//
//  NewsViewController.m
//  GroupPurchaseApp
//
//  Created by Apple2 on 2016/11/25.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "NewsViewController.h"
#import "AdvertisingColumn.h"
#import "HTHorizontalSelectionList.h"
#import "NetApiAndData.h"

#import "JokeTextCell.h"
#import "JokeModel.h"
#import "JokeImageCell.h"
#import "UILabel+Height.h"

#import "NewsModel.h"
#import "NewsCell.h"
#import "WebViewController.h"

#import "WechatModel.h"
#import "WechatCell.h"

#import "HistoryTodayModel.h"
#import "HistoryTodayDetailViewController.h"
#define kJokeTextCell @"jokeTextCell"
#define KNewsCell @"NewsCell"
#define kWechatCell @"WechatCell"
#define kHistoryTodayCell @"HistoryTodayCell"

typedef NS_ENUM(NSInteger, ShowContentStyle){
    ShowContentStyleNew = 0,
    ShowContentStyleJoke,
    ShowContentStyleWechat,
    ShowContentStyleAnotherToday
};

@interface NewsViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource , UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) HTHorizontalSelectionList *selectionList;
@property (strong, nonatomic) UITableView *contentTabelView;
@property (strong, nonatomic) MJRefreshAutoFooter *refreshFooter;
@property (assign, nonatomic) ShowContentStyle showcontentStyle;
@end

@implementation NewsViewController{
    NSArray *_selectionListTitles;
    //joke的实例变量
    NSInteger _jokePage;
    NSMutableArray *_jokeTexts;

    
    //news 的实例变量
    NSInteger _newsPage;
    NSMutableArray *_newsContentArray;
    
    //wechat 的实例变量
    NSInteger _wechatpage;
    NSMutableArray *_wechatContentArray;
    
    //historytoday
    NSString *_date;
    NSMutableArray *_historyTodayContentArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯";
    _selectionListTitles = @[@"新闻头条",@"笑话大全",@"微信精选",@"昨日重现"];
    [self showJokeTableView];
    [self showSelectionList];
    [self requestNewContent];
    
    _jokePage = 1;
    _jokeTexts = [NSMutableArray new];
    
    _newsPage = 1;
    _newsContentArray = [NSMutableArray new];
    
    _wechatpage = 1;
    _wechatContentArray = [NSMutableArray new];
    
    //获取当前时间进行请求
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    _date = [NSString stringWithFormat:@"%ld/%ld",(long)[dateComponent month],(long)[dateComponent day]];
    _historyTodayContentArray = [NSMutableArray new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//根据顶部选择单元的位置决定网路请求并更新数据格式
- (void)setShowcontentStyle:(ShowContentStyle)showcontentStyle{
    _showcontentStyle = showcontentStyle;
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:
            [self requestJokeContent];
            break;
        case ShowContentStyleNew:
            [self requestNewContent];
            break;
        case ShowContentStyleWechat:
            [self requestWechatContent];
            break;
        case ShowContentStyleAnotherToday:
            [self requstHistoryTodayContent];
            break;
        default:
            break;
    }
}


- (void)showSelectionList{
    if(_selectionList == nil){
        _selectionList = [[HTHorizontalSelectionList alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        _selectionList.delegate = self;
        _selectionList.dataSource = self;
        _selectionList.bottomTrimColor = [UIColor lightGrayColor];
        _selectionList.selectionIndicatorColor = kLightGreenColor;
        [self.view addSubview:_selectionList];
    }
}

- (void)showJokeTableView{
    if(!_contentTabelView){
        _contentTabelView = [[UITableView alloc]init];
        _contentTabelView.delegate = self;
        _contentTabelView.dataSource = self;
        _contentTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _contentTabelView.separatorColor = kLightGreenColor;
        _contentTabelView.showsVerticalScrollIndicator = NO;
        //注册所有的CELL
        [self.contentTabelView registerClass:[JokeTextCell class] forCellReuseIdentifier:kJokeTextCell];
        [self.contentTabelView registerClass:[NewsCell class] forCellReuseIdentifier:KNewsCell];
        [self.contentTabelView registerClass:[WechatCell class] forCellReuseIdentifier:kWechatCell];
        
        [self.view addSubview:_contentTabelView];
        [_contentTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(30);
        }];
    }
    _contentTabelView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    _contentTabelView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

//refresh footer 的方法

- (void)updateData{
    [self.contentTabelView.mj_header endRefreshing];
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:{
            if(_jokeTexts.count > 0){
            //当remove全部数据时 addobjectformarray 会报错，因此留一个数据
                [_jokeTexts removeObjectsInRange:NSMakeRange(0, _jokeTexts.count - 1)];
            }
            [self requestJokeContent];
            
        }
            break;
        case ShowContentStyleNew:{
            if(_newsContentArray.count > 0){
                [_newsContentArray removeObjectsInRange:NSMakeRange(0, _newsContentArray.count - 1)];
            }
            [self requestNewContent];
        }
            break;
        case ShowContentStyleWechat:{
            if(_wechatContentArray.count > 0){
                [_wechatContentArray removeObjectsInRange:NSMakeRange(0, _wechatContentArray.count - 1)];
            }
            [self requestWechatContent];
        }
            break;
        case ShowContentStyleAnotherToday:
            [self requstHistoryTodayContent];
        default:
            break;
    }

}
- (void)loadMore{
    [self.contentTabelView.mj_footer endRefreshing];
    
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:{
            _jokePage ++;
            [self requestJokeContent];
        }
            break;
        case ShowContentStyleNew:{
            _newsPage++;
            [self requestNewContent];
        }
            break;
        case ShowContentStyleWechat:{
            _wechatpage++;
            [self requestWechatContent];
        }
            break;
        default:
            break;
    }

}
//joke

#pragma  mark - request 

- (void)requestJokeContent{
    NetApiAndData *net = [NetApiAndData shareManager];
    [net requestJokeContentWithPage:_jokePage returnData:^(id data, NSError *error) {
        if(error){
            return ;
        }
        [_jokeTexts addObjectsFromArray: [JokeModel getJokeContents:data]];
        [self.contentTabelView reloadData];
    }];
}

- (void)requestNewContent{
    NetApiAndData *net = [NetApiAndData shareManager];
    [net requestNewsContentWithType:_newsPage returnData:^(id data, NSError *error) {
        if(error)  return ;
        [_newsContentArray addObjectsFromArray:[NewsModel getNews:data]];
        [self.contentTabelView reloadData];
        
    }];
}

- (void)requestWechatContent{
    NetApiAndData *net = [NetApiAndData shareManager];
    [net requestWechatContentWithType:_wechatpage returnData:^(id data, NSError *error) {
        if(error) return ;
        [_wechatContentArray addObjectsFromArray:[WechatModel getWechatData:data]];
        [self.contentTabelView reloadData];
    }];
}

- (void)requstHistoryTodayContent{
    NetApiAndData *net = [NetApiAndData shareManager];
    [net requestHistoryTodayContentWithDate:_date returnData:^(id data, NSError *error) {
        if(error) return ;
        [_historyTodayContentArray addObjectsFromArray:[HistoryTodayModel getHistoryTodayContent:data]];
        [self.contentTabelView reloadData];
    }];
}

#pragma  mark - selection list delegate and datasouce
//selection list delegate
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList{

    return _selectionListTitles.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index{
    
    return _selectionListTitles[index];
}

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index{
    self.showcontentStyle = index;
}


#pragma mark - tableview delegate and datasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger number;
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:
            number = _jokeTexts.count;
            break;
        case ShowContentStyleNew:
            number = _newsContentArray.count;
            break;
        case ShowContentStyleWechat:
            number = _wechatContentArray.count;
            break;
        case ShowContentStyleAnotherToday:
            number = _historyTodayContentArray.count;
            break;
        default:
            break;
    }
    return number ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:{
            JokeTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kJokeTextCell];
            JokeModel *jokeTextModel = _jokeTexts.count >= indexPath.section + 1 ? _jokeTexts[indexPath.section] : nil;
            cell.jokeText = jokeTextModel.jokeContent;
            return cell;
        }
        case ShowContentStyleNew:{
            NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:KNewsCell];
            NewsModel *newsModel = _newsContentArray.count >= indexPath.section + 1 ? _newsContentArray[indexPath.section] : nil;
            [cell setNewContent: newsModel];
            return cell;
        }
        case ShowContentStyleWechat:{
            WechatCell *cell = [tableView dequeueReusableCellWithIdentifier:kWechatCell];
            WechatModel *wechatModel = _wechatContentArray.count >= indexPath.section + 1 ? _wechatContentArray[indexPath.section] : nil;
            [cell setWechatContent:wechatModel];
            return cell;
        }
        case ShowContentStyleAnotherToday:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHistoryTodayCell];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kHistoryTodayCell];
            }
            HistoryTodayModel *historyToday = _historyTodayContentArray.count >= indexPath.section + 1 ? _historyTodayContentArray[indexPath.section] : nil;
            cell.textLabel.text = historyToday.title;
            cell.detailTextLabel.text = historyToday.date;
            return cell;
        }
        default:
            return nil;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:{
            JokeModel *jokeTextModel = _jokeTexts.count > indexPath.section + 1 ? _jokeTexts[indexPath.section] : nil;
            height = [UILabel labelHeightWithString:jokeTextModel.jokeContent] + 80;
        }
            break;
        case ShowContentStyleNew:{
            height = 360;
        }
            break;
        case ShowContentStyleWechat:{
            height = 260;
        }
            break;
        case  ShowContentStyleAnotherToday:
            height = 60;
            break;
        default:
            break;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view ;
    if(section != 0){
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
        view.backgroundColor = kLightGreenColor;
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if(section != 0){
        height = 1;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_showcontentStyle) {
        case ShowContentStyleJoke:
            break;
        case ShowContentStyleNew:{
            NewsModel *newModel = _newsContentArray[indexPath.section];
            WebViewController *webVC = [[WebViewController alloc]init];
            webVC.URL = newModel.URL;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case ShowContentStyleWechat:{
            WechatModel *wechatModel = _wechatContentArray[indexPath.section];
            WebViewController *webVC = [[WebViewController alloc]init];
            webVC.URL = wechatModel.URL;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case ShowContentStyleAnotherToday:{
            HistoryTodayModel *historyDetailModel = _historyTodayContentArray[indexPath.section];
            HistoryTodayDetailViewController *detailVC = [[HistoryTodayDetailViewController alloc]init];
            detailVC.eventID = historyDetailModel.eventID;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
