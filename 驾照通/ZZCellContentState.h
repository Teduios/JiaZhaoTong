//
//  ZZCellContentState.h
//  驾照通
//
//  Created by Tarena on 16/5/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCellContentState : NSObject<NSCoding>

@property(nonatomic,assign)BOOL isButtonEnabled;
@property(nonatomic,strong)NSString *anwser;
@property(nonatomic,strong)NSString *AbuttonImage;
@property(nonatomic,strong)NSString *BbuttonImage;
@property(nonatomic,strong)NSString *CbuttonImage;
@property(nonatomic,strong)NSString *DbuttonImage;
@property(nonatomic,assign)int num;

@end
