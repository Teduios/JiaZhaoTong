//
//  ZZWeatherTableViewController.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZWeatherTableViewController.h"
#import "ZZSuggestionTableViewCell.h"
#import "ZZNowTableViewCell.h"
#import "ZZHeadView.h"
#import "ZZDailyTableViewCell.h"
#import "ZZNetServer.h"
#import "ZZTodayHead.h"
#import "MJRefresh.h"
#import "ZZManeger.h"
@interface ZZWeatherTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ZZAllData *allData;
@property (nonatomic, strong) UIImage *oldImage;
@property (nonatomic, strong) UIView *activeView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZZHeadView *headView;
@property (nonatomic, strong) UIImageView *backGroundImageView;
@end
@implementation ZZWeatherTableViewController
- (NSString *)cityName {
    if (!_cityName) {
        _cityName = @"北京";
    }
    return _cityName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViewData];
    [self addActiveView];
    [self setNavigationAndTabbar];
}
- (void)setNavigationAndTabbar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:@"cityChange" object:nil];
    [self cityChange:nil];
    self.oldImage = self.tabBarController.tabBar.backgroundImage;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.frame.origin.y == 244) {
        CGFloat f = scrollView.contentOffset.y*1.0/100;
        self.headView.alpha = 1 - f;
        if (self.headView.alpha <= 0) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect rect = self.tableView.frame;
                rect.origin.y = 64;
                rect.size.height += 200;
                self.tableView.frame =rect;
            }];
        }
        
    }
    else {
        if (scrollView.contentOffset.y <0){
            [UIView animateWithDuration:0.5 animations:^{
                self.headView.alpha = 1;
                CGRect rect = self.tableView.frame;
                rect.origin.y = 244;
                rect.size.height -= 200;
                
                self.tableView.frame =rect;
                
            }];}
        
    }
}
- (void)setTableViewData {
    self.backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backGroundImageView.image = [UIImage imageNamed:@"sunny"];
    [self.view addSubview:self.backGroundImageView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 244, self.view.bounds.size.width, self.view.bounds.size.height-244-49)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"ZZHeadView" owner:self options:nil]lastObject];
    _headView.backgroundColor = [UIColor clearColor];
    _headView.frame = CGRectMake(0, 44, self.view.frame.size.width, 200);
    [self.backGroundImageView addSubview:_headView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(cityChange:)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)addActiveView {
    self.activeView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.activeView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIActivityIndicatorView *activ = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activ.frame = CGRectMake(0, 0, 40, 40);
    activ.center = self.activeView.center;
    [self.activeView addSubview:activ];
    [activ startAnimating];
    [self.view addSubview:self.activeView];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setBackgroundImage:self.oldImage];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
}
- (void)cityChange:(NSNotification *)notifier {
    self.cityName = [NSString stringWithContentsOfFile:[ZZManeger getCurrentCityName] encoding:NSUTF8StringEncoding error:nil] ;
    self.navigationItem.title = self.cityName;
    NSString *cityNum = [ZZDataTool getCurrentCityNumber:self.navigationItem.title];
    [ZZNetServer getAllDataWithCity:cityNum withComplationHandel:^(ZZAllData *array, NSError *error) {
        _allData = array;
        [self.tableView.mj_header endRefreshing];
        self.activeView.hidden = YES;
        NSString *condStr = self.allData.now[@"cond"][@"code"];
        NSNumber *num = (NSNumber *)condStr;
        ZZStaticData *data = [ZZStaticData sharedWithWeather];

        switch (num.intValue) {
            case 300 ... 312:{
                self.backGroundImageView.image = [UIImage imageNamed:@"rain"];
                              data.weatherChoose = RAIN;
                break;}
            case 101 ... 205:{
                self.backGroundImageView.image =[UIImage imageNamed:@"cloud"];
                              data.weatherChoose = CLOD;
                break;}
        }
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:data.weatherChoose == RAIN?rainColor:clodColor}];
        [self.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            ZZNowTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ZZNowTableViewCell" owner:self options:nil]lastObject];
            [cell setAllNowData:[ZZDataTool loadAllNowDataWith:self.allData.now]];
            cell.backgroundColor = [UIColor clearColor];
            cell.userInteractionEnabled = NO;
                       return cell;
            
        }
            break;
        case 1:
        {
            ZZDailyTableViewCell *cell = [[ZZDailyTableViewCell alloc]init];
            cell.backgroundColor = [UIColor clearColor];
            [cell setDailyData:self.allData.daily_forecast];
            [cell setSelectedBackgroundView:nil];
            
            return cell;
        }
            
            break;
            
        default:
        {
            ZZSuggestionTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ZZSuggestionTableViewCell" owner:self options:nil]lastObject];
            cell.backgroundColor = [UIColor clearColor];
            [cell setDatasWith:[ZZDataTool loadAllSuggerstionWith:self.allData.suggestion]];
            cell.userInteractionEnabled = NO;
            return cell;
        }
            break;
    }
    
    
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        [_headView setHeaderWith:self.allData];
        ZZTodayHead *headView = [[[NSBundle mainBundle]loadNibNamed:@"ZZTodayHead" owner:self options:nil]lastObject];
        [headView setData:self.allData];
        headView.backgroundColor = [UIColor clearColor];
        headView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 30);
        return headView;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 100;
            break;
        default:
            return 150;
            break;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"1";
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    }
    return 0;
    
}
@end

