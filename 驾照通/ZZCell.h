//
//  Cell.h
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResult.h"
#import "ZZCellContentState.h"
typedef void(^ScoreBlock)();

typedef void(^stateBlock)(ZZCellContentState *);



@interface ZZCell : UICollectionViewCell
//@property(nonatomic,strong)Result *result;
@property(nonatomic,assign)int num;
-(void)setCell:(ZZResult*)result;
-(void)removeAllContent;

@property(nonatomic,strong)ScoreBlock scoreblock;
@property(nonatomic,strong)stateBlock stateFromTestblock;
@property(nonatomic,strong)NSString *who;
@property(nonatomic,strong)NSArray *stateArray;
@property(nonatomic,strong)NSString *subject;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,assign)long allNum;
@end
