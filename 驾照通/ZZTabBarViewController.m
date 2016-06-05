//
//  ZZTabBarViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZTabBarViewController.h"

@interface ZZTabBarViewController ()

@end

@implementation ZZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize
{
    if (self == [ZZTabBarViewController class]) {
        UITabBar *bar = [UITabBar appearance];
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
