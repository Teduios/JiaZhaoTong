//
//  ZZCellArray.h
//  驾照通
//
//  Created by Tarena on 16/5/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCellStateArray : NSObject
/**
 *  获取cell状态单例数组
 *
 *  @param who 练习或错题或收藏
 *
 *  @return 单例的可变数组
 */
+(NSMutableArray*)getCellStateArray:(NSString*)who;

@end
