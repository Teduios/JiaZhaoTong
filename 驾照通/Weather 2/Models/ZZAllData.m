//
//  ZZAllData.m
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZAllData.h"

@implementation ZZAllData
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
- (id)copyWithZone:(NSZone *)zone {
    return [[ZZAllData allocWithZone:zone]init];
}
@end
