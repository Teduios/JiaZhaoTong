//
//  ZZAllData.h
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZStaticData.h"
@interface ZZAllData : NSObject<NSCopying>
@property (nonatomic, strong) NSDictionary *aqi;
@property (nonatomic, strong) NSDictionary *now;
@property (nonatomic, strong) NSDictionary *suggestion;
@property (nonatomic, strong) NSArray *daily_forecast;
@property (nonatomic, assign) NSInteger colorInt;
@end
