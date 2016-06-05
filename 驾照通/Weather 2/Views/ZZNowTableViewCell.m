//
//  ZZNowTableViewCell.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZNowTableViewCell.h"
@interface ZZNowTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nowTmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowFlLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowDirLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowHumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowVisLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPresLabel;


@end
@implementation ZZNowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)setAllNowData:(ZZNow *)now {
     ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    self.nowTmpLabel.text = [NSString stringWithFormat:@" %@°",now.tmp];
    self.nowTmpLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    
     self.nowFlLabel.text = [NSString stringWithFormat:@" %@°",now.fl];
    self.nowFlLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    
     self.nowHumLabel.text = [NSString stringWithFormat:@" %@%%",now.hum];
    self.nowHumLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    
    self.nowVisLabel.text = [NSString stringWithFormat:@" %@ 公里",now.vis];
    self.nowVisLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    
     self.nowPresLabel.text = [NSString stringWithFormat:@" %@ 百帕",now.pres];
    self.nowPresLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    
     self.nowDirLabel.text = [NSString stringWithFormat:@" %@",now.wind[@"dir"]];
    self.nowDirLabel.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
    for (int i = 20; i<26; i++) {
        UILabel *label = [self viewWithTag:i];
        label.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;

    }
}
@end
