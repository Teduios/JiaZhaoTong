//
//  ZZNetServer.h
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDataTool.h"
@interface ZZNetServer : NSObject
+ (void)getAllDataWithCity:(NSString *)cityName withComplationHandel:(void(^)(ZZAllData *array,NSError *error))DATA_TASK;
@end
