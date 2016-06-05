//
//  Layout.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZLayout.h"

@implementation ZZLayout

-(instancetype)init {
    if (self = [super init]) {
        CGRect ScreenRect = [UIScreen mainScreen].bounds;
        //1.项的大小
        self.itemSize = CGSizeMake(ScreenRect.size.width, ScreenRect.size.height-64);
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //5.设置 布局 为水平方向
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
