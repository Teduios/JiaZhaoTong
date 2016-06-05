//
//  ZZZZAllCollectionViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZAllCollectionViewController.h"
#import "ZZManeger.h"
#import "ZZCell.h"
#import "ZZResult.h"
#import "UIImageView+WebCache.h"
#import "ZZCellStateArray.h"

@interface ZZAllCollectionViewController ()
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger historyNum;
@property(nonatomic,strong)NSString *historyPath;
@property(nonatomic,assign) int score;
@property(nonatomic,assign) long allNum;
@end

@implementation ZZAllCollectionViewController
//历史路径，记录做到哪题
-(NSString *)historyPath
{
    if (_historyPath==nil) {
        NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *file=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@history.plist",self.model,self.subject,self.who]];
        _historyPath=file;
    }
    return _historyPath;
}
-(NSArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[ZZManeger LoadDataWithModel:self.model Subject:self.subject]copy];
    }
    return _dataArray;
}



static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled=YES;
    self.navigationItem.title=[NSString stringWithFormat:@"%@%@%@",self.model,self.subject,self.who];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZZCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackVC)];
    self.navigationItem.leftBarButtonItem=item;
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:self.historyPath];
    if (dic) {
        NSInteger historyNum=[dic[@"history"] integerValue];
        self.collectionView.contentOffset = CGPointMake(self.view.bounds.size.width*historyNum, 0);
    }
    if ([self.who isEqualToString:@"错题"] || [self.who isEqualToString:@"收藏"]) {
        [self clear];
    }
}
//当是错题或收藏界面时添加清空按钮
-(void)clear
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:[self.who isEqualToString:@"错题"]?@"清空错题":@"清空收藏" style:UIBarButtonItemStylePlain target:self action:@selector(deleteFile)];
    
}

-(void)deleteFile
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:[self.who isEqualToString:@"错题"]?@"是否清空错题":@"是否清空收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *YESaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *filePath;
        if ([self.who isEqualToString:@"错题"]) {
            filePath=[ZZManeger getWrongPathWithModel:self.model subject:self.subject];
        }
        else
        {
            filePath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
        }
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *NOaction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:YESaction];
    [alert addAction:NOaction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}



//pop回上一界面相关操作
-(void)goBackVC
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存做题记录,下次进入从该题开始" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *YesAction=[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self writeHistoryNum];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *NoAction=[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.historyNum=0;
        [self writeHistoryNum];
        [ZZManeger deleteCellStateFielWithModel:self.model subject:self.subject who:self.who];
        [[ZZCellStateArray getCellStateArray:self.who]removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:YesAction];
    [alert addAction:cancelAction];
    [alert addAction:NoAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

-(void)writeHistoryNum
{
    NSDictionary *dic=@{@"history":[NSNumber numberWithInteger:self.historyNum]};
    [dic writeToFile:self.historyPath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.who isEqualToString:@"练习"]) {
        self.allNum=self.dataArray.count;
        return self.dataArray.count;
    }
    else if ([self.who isEqualToString:@"错题"])
    {
        NSString *wrongPath=[ZZManeger getWrongPathWithModel:self.model subject:self.subject];
        self.allNum=[NSArray arrayWithContentsOfFile:wrongPath].count;
        return [NSArray arrayWithContentsOfFile:wrongPath].count;
    }
    else
    {
        NSString *collectPath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
        self.allNum=[NSArray arrayWithContentsOfFile:collectPath].count;
        return [NSArray arrayWithContentsOfFile:collectPath].count;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell removeAllContent];
    ZZResult *result;
    if ([self.who isEqualToString:@"练习"]) {
        result=self.dataArray[indexPath.section];
    }
    else if ([self.who isEqualToString:@"错题"])
    {
        NSString *wrongPath=[ZZManeger getWrongPathWithModel:self.model subject:self.subject];
        NSArray *array=[NSArray arrayWithContentsOfFile:wrongPath];
        
        NSInteger num=[array[indexPath.section] integerValue];
        result=self.dataArray[num];
    }
    else
    {
        NSString *collectPath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
        NSArray *array=[NSArray arrayWithContentsOfFile:collectPath];
        
        NSInteger num=[array[indexPath.section] integerValue];
        result=self.dataArray[num];
    }
    cell.num=(int)indexPath.section;
    cell.scoreblock=^()
    {
        self.score+=1;
    };
    cell.who=self.who;
    cell.subject=self.subject;
    cell.model=self.model;
    cell.allNum=self.allNum;
    [cell setCell:result];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.historyNum=indexPath.section;
}




@end
