//
//  ZZNetServer.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZNetServer.h"

@implementation ZZNetServer
static const NSString *key = @"ef80661c888b4c9dbc31bc52d8a932c6";
+ (void)getAllDataWithCity:(NSString *)cityName withComplationHandel:(void (^)(ZZAllData *, NSError *))DATA_TASK{
    NSString *keyPath = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=%@",cityName,key];
    NSURLSession *ssion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [ssion dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:keyPath]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (![dic[@"HeWeather data service 3.0"][0][@"status"] isEqualToString:@"ok"]) {
                    [self didFailDownLoadwithComplationHandel:DATA_TASK];
                }
                else {
                    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
                    NSString *newPath = [path stringByAppendingPathComponent:@"Caches/weather.txt"];
                    [dic writeToFile:newPath atomically:YES];
                    DATA_TASK([ZZDataTool loadAllDataWith:[dic[@"HeWeather data service 3.0"] firstObject]],nil);
                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self didFailDownLoadwithComplationHandel:DATA_TASK];
            });
        }
        
    }];
    [task resume];
}

+(void)didFailDownLoadwithComplationHandel:(void (^)(ZZAllData *, NSError *))DATA_TASK{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    NSString *newPath = [path stringByAppendingPathComponent:@"Caches/weather.txt"];
    NSDictionary *newDic = [NSDictionary dictionaryWithContentsOfFile:newPath];
    if (newDic == nil) {
        newDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tempWeather.plist" ofType:nil]];
    }
    DATA_TASK([ZZDataTool loadAllDataWith:[newDic[@"HeWeather data service 3.0"] firstObject]],nil);
}

@end
