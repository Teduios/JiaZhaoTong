//
//  ZZNow.h
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZStaticData.h"
@interface ZZNow : NSObject
//天气状况
@property (nonatomic, strong) NSDictionary *cond;
//体感温度
@property (nonatomic, strong) NSString *fl;
//湿度
@property (nonatomic, strong) NSString *hum;
//当前温度
@property (nonatomic, strong) NSString *tmp;
//能见度
@property (nonatomic, strong) NSString *vis;
//风力状况
@property (nonatomic, strong) NSDictionary *wind;
//气压
@property (nonatomic, strong) NSString *pres;
@end
