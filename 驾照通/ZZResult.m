//
//  Result.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZResult.h"

@implementation ZZResult

-(instancetype)initWithDictionaty:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.answer=dic[@"answer"];
        self.explains=dic[@"explains"];
        self.item1=dic[@"item1"];
        self.item2=dic[@"item2"];
        self.item3=dic[@"item3"];
        self.item4=dic[@"item4"];
        self.question=dic[@"question"];
        self.url=dic[@"url"];
    }
    return self;
}



+(instancetype)initWithDictionary:(NSDictionary *)dic
{
    return [[ZZResult alloc]initWithDictionaty:dic];
}
@end
