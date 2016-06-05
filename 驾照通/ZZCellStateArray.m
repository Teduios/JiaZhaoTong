//
//  ZZCellArray.m
//  驾照通
//
//  Created by Tarena on 16/5/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZCellStateArray.h"

@implementation ZZCellStateArray

 static NSMutableArray *AllStateArray;
+(NSMutableArray *)sharedAllCellStateArray
{
    if (AllStateArray==nil) {
        AllStateArray=[NSMutableArray array];
    }
    return AllStateArray;
}

static NSMutableArray *WrongStateArray;
+(NSMutableArray *)sharedWrongCellStateArray
{
    if (WrongStateArray==nil) {
        WrongStateArray=[NSMutableArray array];
    }
    return WrongStateArray;
}

static NSMutableArray *CollectStateArray;
+(NSMutableArray *)sharedCollectCellStateArray
{
    if (CollectStateArray==nil) {
        CollectStateArray=[NSMutableArray array];
    }
    return CollectStateArray;
}

+(NSMutableArray*)getCellStateArray:(NSString*)who
{
    if ([who isEqualToString:@"练习"]) {
        return [ZZCellStateArray sharedAllCellStateArray];
    }
    else if ([who isEqualToString:@"错题"])
    {
        return [ZZCellStateArray sharedWrongCellStateArray];
    }
    else
    {
        return [ZZCellStateArray sharedCollectCellStateArray];
    }
}

@end
