//
//  ZZDailyView.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZDailyView.h"
@interface ZZDailyView()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation ZZDailyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//   UIBezierPath *
//}

- (void)setDailyDataWith:(ZZdaliy *)daily {
    ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    self.dateLabel.text = daily.date;
    self.dateLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    self.tmpLabel.text = [NSString stringWithFormat:@"%@° ~ %@°",daily.tmp[@"min"],daily.tmp[@"max"]];
    self.tmpLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    NSString *path = [NSString stringWithFormat:@"http://files.heweather.com/cond_icon/%@.png",daily.cond[@"code_d"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
    UIImage *images = [[UIImage alloc]initWithData:data];
    self.image.image = images;
}

@end
