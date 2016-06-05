//
//  ZZTodayHead.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZTodayHead.h"
@interface ZZTodayHead()

@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@end
@implementation ZZTodayHead

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setData:(ZZAllData *)allData{
     ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    self.todayDateLabel.text = [NSString stringWithFormat:@"%@  今天",allData.daily_forecast[0][@"date"]];
    self.tmpLabel.text = [NSString stringWithFormat:@"%@° ~ %@°",allData.daily_forecast[0][@"tmp"][@"min"],allData.daily_forecast[0][@"tmp"][@"max"]];
    self.todayDateLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    self.tmpLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
}
@end
