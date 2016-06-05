//
//  ZZHeadView.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZHeadView.h"
@interface ZZHeadView()

@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@property (weak, nonatomic) IBOutlet UILabel *clodLabel;
@property (weak, nonatomic) IBOutlet UILabel *aqiLabel;

@end
@implementation ZZHeadView
- (void)setHeaderWith:(ZZAllData *)allData {
     ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    self.tmpLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;;
    self.tmpLabel.text = [NSString stringWithFormat:@"%@°",allData.now[@"tmp"]];
    self.aqiLabel.text = [NSString stringWithFormat:@"空气:%@",allData.aqi[@"city"][@"qlty"]];
    self.aqiLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    self.clodLabel.text = allData.now[@"cond"][@"txt"];
    self.clodLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
