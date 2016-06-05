//
//  ZZTestCollectionViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZTestCollectionViewController.h"
#import "ZZManeger.h"
#import "ZZCell.h"
#import "ZZResult.h"
#import "UIImageView+WebCache.h"
#import "ZZCellContentState.h"
@interface ZZTestCollectionViewController ()
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *testArray;
@property(nonatomic,strong)NSMutableArray *stateArray;
@property(nonatomic,assign)int score;
@end

@implementation ZZTestCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray=[ZZManeger getTestArray];
    }
    return _dataArray;
}
-(NSMutableArray *)stateArray
{
    if (_stateArray==nil) {
        _stateArray=[NSMutableArray array];
    }
    return _stateArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score=0;
    self.collectionView.pagingEnabled=YES;
    self.navigationItem.title=[NSString stringWithFormat:@"%@%@考试",self.model,self.subject];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZZCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackVC)];
    self.navigationItem.leftBarButtonItem=item;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"作答完毕" style:UIBarButtonItemStylePlain target:self action:@selector(didTest)];
}

-(void)didTest
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"分数" message:[NSString stringWithFormat:@"%d",self.score] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *YesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:YesAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

-(void)goBackVC
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出考试\n结果将不保存" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *YesAction=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *NoAction=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:YesAction];
    [alert addAction:NoAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell removeAllContent];
    cell.scoreblock=^()
    {
        self.score+=1;
    };
    cell.stateFromTestblock=^(ZZCellContentState *state)
    {
        [self.stateArray addObject:state];
    };
    if (self.stateArray.count) {
        cell.stateArray=[self.stateArray copy];
    }
    ZZResult *result=self.dataArray[indexPath.section];
    cell.num=(int)indexPath.section;
    cell.who=@"考试";
    cell.allNum=99;
    [cell setCell:result];
    return cell;
}

@end
