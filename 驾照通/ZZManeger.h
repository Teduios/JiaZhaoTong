//
//  Maneger.h
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoadTestBlock)();

@interface ZZManeger : NSObject
/**
 *  加载本地非考试界面的数据
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 *
 *  @return 结果数组
 */
+(NSArray*)LoadDataWithModel:(NSString*)model Subject:(NSString*)subject;
/**
 *  网络请求考试数据并用NSUserDefault存储
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 */
-(void)LoadTestDataWithModel:(NSString *)model Subject:(NSString *)subject;
/**
 *  下载得到考试界面数据
 *
 *  @return 结果数组
 */
+(NSArray *)getTestArray;

/**
 *  得到错题plist文件的路径
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 *
 *  @return 错题路径字符串
 */
+(NSString*)getWrongPathWithModel:(NSString*)model subject:(NSString*)subject;

/**
 *  得到收藏plist文件的路径
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 *
 *  @return 收藏路径字符串
 */
+(NSString*)getCollectPathWithModel:(NSString*)model subject:(NSString*)subject;

/**
 *  删除cell状态文件
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 *  @param who     练习或错题或收藏
 */
+(void)deleteCellStateFielWithModel:(NSString*)model subject:(NSString*)subject who:(NSString*)who
;

/**
 *  获取cell状态文件路径
 *
 *  @param model   驾照类型（c1,c2,b1,b2）
 *  @param subject 科目类型
 *  @param who     练习或错题或收藏
 *
 *  @return 路径字符串
 */
+(NSString*)getCellStatePathWithModel:(NSString*)model subject:(NSString*)subject who:(NSString*)who
;

+(NSString*)getCurrentCityName;

@property(nonatomic,strong)LoadTestBlock block;


@end
