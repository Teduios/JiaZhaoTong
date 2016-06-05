//
//  ZZStaticData.h
//  ZZTest
//
//  Created by Tarena on 16/5/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#define rainColor [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define clodColor [UIColor colorWithRed:83.0/255 green:83.0/255 blue:83.0/255 alpha:1]
@interface ZZStaticData : NSObject
typedef enum {
    RAIN,
    CLOD
}weatherSwitch;
@property (nonatomic, assign) weatherSwitch weatherChoose;
+ (instancetype)sharedWithWeather;
@end
