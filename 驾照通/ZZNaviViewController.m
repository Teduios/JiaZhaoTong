//
//  ZZNaviViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZNaviViewController.h"

@interface ZZNaviViewController ()

@end

@implementation ZZNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)initialize
{
    if (self== [ZZNaviViewController class]) {
        UINavigationBar *bar=[UINavigationBar appearance];
        //[bar setBackgroundImage:[UIImage imageNamed:@"2013-09-15-18.24.36"] forBarMetrics:UIBarMetricsDefault];
        [bar setBackgroundColor:[UIColor clearColor]];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
