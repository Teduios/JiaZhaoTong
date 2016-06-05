//
//  ZZCellContentState.m
//  驾照通
//
//  Created by Tarena on 16/5/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZCellContentState.h"

@implementation ZZCellContentState

//把所有的属性进行编码操作
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.isButtonEnabled forKey:@"isButtonEnabled"];
    [aCoder encodeObject:self.anwser forKey:@"anwser"];
    [aCoder encodeObject:self.AbuttonImage forKey:@"AbuttonImage"];
    [aCoder encodeObject:self.BbuttonImage forKey:@"BbuttonImage"];
    [aCoder encodeObject:self.CbuttonImage forKey:@"CbuttonImage"];
    [aCoder encodeObject:self.DbuttonImage forKey:@"DbuttonImage"];
    [aCoder encodeInt:self.num forKey:@"num"];
}

//把所有的属性进行解码操作
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.isButtonEnabled=[aDecoder decodeBoolForKey:@"isButtonEnabled"];
        self.anwser=[aDecoder decodeObjectForKey:@"anwser"];
        self.AbuttonImage=[aDecoder decodeObjectForKey:@"AbuttonImage"];
        self.BbuttonImage=[aDecoder decodeObjectForKey:@"BbuttonImage"];
        self.CbuttonImage=[aDecoder decodeObjectForKey:@"CbuttonImage"];
        self.DbuttonImage=[aDecoder decodeObjectForKey:@"DbuttonImage"];
        self.num=[aDecoder decodeIntForKey:@"num"];
           }
    return self;
}


@end
