//
//  ZZSuggestionTableViewCell.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZSuggestionTableViewCell.h"
#import "ZZSuggestion.h"
#import "ZZLabel.h"
@interface ZZSuggestionTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *sportLabel;
@property (weak, nonatomic) IBOutlet UILabel *fluLabel;
@property (weak, nonatomic) IBOutlet UILabel *drsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfLabel;
@property (weak, nonatomic) IBOutlet UILabel *travLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvLabel;
@end
@implementation ZZSuggestionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)setDatasWith:(NSArray *)array {
    if (array.count == 0) {
        return;
    }
     ZZStaticData *data1 = [ZZStaticData sharedWithWeather];
    for (int i = 1; i<7; i++) {
        ZZLabel *label = [self.contentView viewWithTag:i];
        ZZSuggestion *se = array[i-1];
        label.textColor = data1.weatherChoose == RAIN?rainColor:clodColor;
        label.text = se.txt;
    }
}
@end
