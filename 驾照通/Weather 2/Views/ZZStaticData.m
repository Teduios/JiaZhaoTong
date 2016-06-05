//
//  ZZStaticData.m
//  ZZTest
//
//  Created by Tarena on 16/5/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZStaticData.h"

@implementation ZZStaticData
static ZZStaticData *weatherData = nil;
+ (instancetype)sharedWithWeather {
    if (!weatherData) {
        weatherData = [ZZStaticData new];
        
    }
    return weatherData;
}
@end
