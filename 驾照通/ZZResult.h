//
//  Result.h
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZResult : NSObject
@property(nonatomic,strong)NSString *answer;
@property(nonatomic,strong)NSString *explains;
@property(nonatomic,strong)NSString *item1;
@property(nonatomic,strong)NSString *item2;
@property(nonatomic,strong)NSString *item3;
@property(nonatomic,strong)NSString *item4;
@property(nonatomic,strong)NSString *question;
@property(nonatomic,strong)NSString *url;

+(instancetype)initWithDictionary:(NSDictionary*)dic;

-(instancetype)initWithDictionaty:(NSDictionary*)dic;
@end
