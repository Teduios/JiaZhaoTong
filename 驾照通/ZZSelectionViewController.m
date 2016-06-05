//
//  ZZSelectionViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZSelectionViewController.h"
#import "ZZAllCollectionViewController.h"
#import "ZZTestCollectionViewController.h"
#import "ZZLayout.h"
#import "ZZManeger.h"
@interface ZZSelectionViewController ()
@property(nonatomic,strong)UIView *grayView;
@end

@implementation ZZSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=[NSString stringWithFormat:@"%@%@",self.model,self.subject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//根据点击的button不同跳转
- (IBAction)buttonClick:(UIButton*)sender {
    ZZLayout *layout=[[ZZLayout alloc]init];
    switch (sender.tag) {
        case 0:
            [self goToAllVC:layout];
            break;
        case 1:
            [self goToTestVC:layout];
            break;
        case 2:
            [self goToWrongVC:layout];
            break;
        default:
            [self goToCollectVC:layout];
            break;
    }
}

-(void)goToAllVC:(ZZLayout*)layout
{
    [self goToVCExpectTestVC:layout andWho:@"练习"];
}


-(void)goToWrongVC:(ZZLayout*)layout
{
    NSString *wrongPath=[ZZManeger getWrongPathWithModel:self.model subject:self.subject];
    NSArray *array=[NSArray arrayWithContentsOfFile:wrongPath];
    if (array.count!=0) {
        [self goToVCExpectTestVC:layout andWho:@"错题"];
    }
    else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"目前还没有错题" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *YesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:YesAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
        
    
}
-(void)goToCollectVC:(ZZLayout*)layout
{
    NSString *collectPath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
    NSArray *array=[NSArray arrayWithContentsOfFile:collectPath];
    if (array.count!=0) {
        [self goToVCExpectTestVC:layout andWho:@"收藏"];
    }
    else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"目前还没有收藏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *YesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:YesAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}


-(void)goToVCExpectTestVC:(ZZLayout*)layout andWho:(NSString*)who
{
    ZZAllCollectionViewController *allVC=[[ZZAllCollectionViewController alloc]initWithCollectionViewLayout:layout];
    allVC.model=self.model;
    allVC.subject=self.subject;
    allVC.who=who;
    [self.navigationController pushViewController:allVC animated:YES];
}



-(void)goToTestVC:(ZZLayout*)layout
{
    [self loadData];
    ZZTestCollectionViewController*testVC=[[ZZTestCollectionViewController alloc]initWithCollectionViewLayout:layout];
    testVC.model=self.model;
    testVC.subject=self.subject;
    ZZManeger *manage=[[ZZManeger alloc]init];
    [manage LoadTestDataWithModel:self.model Subject:self.subject];
    manage.block=^()
    {
        self.grayView.hidden=YES;
        [self.navigationController pushViewController:testVC animated:YES];
    };
}
//下载考试数据时出现动画
- (void)loadData {
    self.grayView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.grayView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:0.7];
    UIActivityIndicatorView *activ = [UIActivityIndicatorView new];
    [activ startAnimating];
    activ.frame = CGRectMake(0, 0, 40, 40);
    activ.color = [UIColor blackColor];
    activ.center = self.grayView.center;
    [self.grayView addSubview:activ];
    [self.view addSubview:self.grayView];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}

@end
