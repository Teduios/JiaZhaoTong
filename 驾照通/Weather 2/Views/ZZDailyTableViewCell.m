//
//  ZZDailyTableViewCell.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZDailyTableViewCell.h"
#import "ZZDailyView.h"
#import "ZZDataTool.h"
@implementation ZZDailyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
static const CGFloat hight = 100;
- (void)setDailyData:(NSArray *)dailyArray {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, hight)];
    scrollView.contentSize = CGSizeMake(width * 2, hight);
    NSArray *array = [ZZDataTool loadAllDaliyDataWith:dailyArray];
    if (array.count == 0) {
        return;
    }
    for (int i = 0; i < array.count-1; i++) {
        ZZDailyView *view = [[[NSBundle mainBundle]loadNibNamed:@"ZZDailyView" owner:self options:nil]lastObject];
        view.backgroundColor = [UIColor clearColor];
        [view setDailyDataWith:array[i+1]];
        view.frame = CGRectMake(i * (width/3), 5, width/3, hight-10);
        [scrollView addSubview:view];
    }
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];

    
}
@end
