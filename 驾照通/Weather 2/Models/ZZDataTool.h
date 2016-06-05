//
//  ZZDataTool.h
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZSuggestion.h"
#import "ZZNow.h"
#import "ZZdaliy.h"
#import "ZZAqi.h"
#import "ZZAllData.h"
@interface ZZDataTool : NSObject
+ (NSArray *)loadAllSuggerstionWith:(NSDictionary *)suggestionDic;
+ (ZZNow *)loadAllNowDataWith:(NSDictionary *)nowDic;
+ (NSArray *)loadAllDaliyDataWith:(NSArray *)dailyArray;
+ (ZZAqi *)loadAqiDataWith:(NSDictionary *)aqiDic;
+ (ZZAllData *)loadAllDataWith:(NSDictionary *)dic;
+ (NSString *)getCurrentCityNumber:(NSString *)cityName;
@end
