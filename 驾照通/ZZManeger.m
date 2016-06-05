//
//  Maneger.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZManeger.h"
#import "ZZResult.h"
@implementation ZZManeger

+(NSArray*)LoadDataWithModel:(NSString*)model Subject:(NSString*)subject
{
    NSMutableArray *muArray=[NSMutableArray array];
    if ([subject isEqualToString:@"科目四"])
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"科目四.plist" ofType:nil];
        NSDictionary * dic=[NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *array=dic[@"result"];
        for (NSDictionary *dic in array ) {
            [muArray addObject:[ZZResult initWithDictionary:dic]];
        }
    }
    else{
        NSString *path=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%@.plist",model,subject] ofType:nil];
        NSDictionary * dic=[NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *array=dic[@"result"];
        for (NSDictionary *dic in array )
        {
            [muArray addObject:[ZZResult initWithDictionary:dic]];
        }
    }
    return muArray;
}


-(void)LoadTestDataWithModel:(NSString *)model Subject:(NSString *)subject
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *string =[NSString new];
        if ([subject isEqualToString:@"科目一"]) {
            string=[NSString stringWithFormat:@"http://api2.juheapi.com/jztk/query?subject=1&model=%@&key=b02e2b0971cbffeffec9a9d5785e5c60&testType=rand",model];
        }
        else
        {
            string=[NSString stringWithFormat:@"http://api2.juheapi.com/jztk/query?subject=4&model=%@&key=b02e2b0971cbffeffec9a9d5785e5c60&testType=rand",model];
        }
        NSURL *url=[NSURL URLWithString:string];
        NSData *data=[NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(),^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=dic[@"result"];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"dic"];
        self.block();
        });
    });
}

+(NSArray *)getTestArray
{
    NSMutableArray *muArray=[NSMutableArray array];
    NSArray *array=[[NSUserDefaults standardUserDefaults]objectForKey:@"dic"];
    for (NSDictionary *dic in array) {
        [muArray addObject:[ZZResult initWithDictionary:dic]];
    }
    return muArray;
}

+(NSString*)getWrongPathWithModel:(NSString*)model subject:(NSString*)subject
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString *wrongPath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@Wrong.plist",model,subject]];
    return wrongPath;
}


+(NSString*)getCollectPathWithModel:(NSString*)model subject:(NSString*)subject
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString *collectPath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@Collect.plist",model,subject]];
    return collectPath;
}

+(NSString*)getCellStatePathWithModel:(NSString*)model subject:(NSString*)subject who:(NSString*)who
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString *cellStatePath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@state.plist",model,subject,who]];
    return cellStatePath;
}

+(void)deleteCellStateFielWithModel:(NSString*)model subject:(NSString*)subject who:(NSString*)who
{
    NSString *cellStatePath=[ZZManeger getCellStatePathWithModel:model subject:subject who:who];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:cellStatePath error:nil];
}

+(NSString *)getCurrentCityName
{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *cityNamePath = [path stringByAppendingPathComponent:@"cityName.txt"];
    return cityNamePath;
}

@end
