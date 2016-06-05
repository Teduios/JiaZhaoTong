//
//  ZZLabel.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZLabel.h"
#import "ZZStaticData.h"
@implementation ZZLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    [[UIColor whiteColor] setStroke];
    path.lineWidth = 1;
    NSString *str = self.text;
     ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    [str drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:data1.weatherChoose == RAIN?rainColor:clodColor,NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [path stroke];
}
@end
