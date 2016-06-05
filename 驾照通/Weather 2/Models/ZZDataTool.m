//
//  ZZDataTool.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZDataTool.h"

@implementation ZZDataTool
+ (NSArray *)loadAllSuggerstionWith:(NSDictionary *)suggestionDic {
    NSArray *dicArray = [suggestionDic allValues];
    NSArray *returnArray = [self loadObjectWith:dicArray withClass:[ZZSuggestion class]];
    return [returnArray copy];
}
+ (ZZNow *)loadAllNowDataWith:(NSDictionary *)nowDic {
    ZZNow *now = [ZZNow new];
    [now setValuesForKeysWithDictionary:nowDic];
    return now;
}
+ (NSArray *)loadAllDaliyDataWith:(NSArray *)dailyArray {
    return [[self loadObjectWith:dailyArray withClass:[ZZdaliy class]] copy];
}
+ (ZZAqi *)loadAqiDataWith:(NSDictionary *)aqiDic {
    ZZAqi *aqi = [ZZAqi new];
    [aqi setValuesForKeysWithDictionary:aqiDic];
    return aqi;
}
+ (NSArray *)loadObjectWith:(NSArray *)dataArray withClass:(Class)modelClass {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        id model = [modelClass new];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return [array copy];
}
+ (ZZAllData *)loadAllDataWith:(NSDictionary *)dic {
    ZZAllData *all = [ZZAllData new];
    [all setValuesForKeysWithDictionary:dic];
    return all;
}
static NSArray *allcity = nil;
+ (NSString *)getCurrentCityNumber:(NSString *)cityName {
    if (!allcity) {
        NSDictionary *cityDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityNumber.plist" ofType:nil]];
        allcity = cityDic[@"city_info"];
    }
    NSString *cityNum = nil;
    for (NSDictionary *dic in allcity) {
        NSString *newCity = [NSString stringWithFormat:@"%@市",dic[@"city"]];
        if ([cityName containsString:newCity]) {
            cityNum = dic[@"id"];
        }
    }
    return cityNum;
}
@end
