//
//  ZZdaliy.h
//  weather
//
//  Created by Tarena on 16/5/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZStaticData.h"
@interface ZZdaliy : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSDictionary *cond;
@property (nonatomic, strong) NSDictionary *tmp;

@end
