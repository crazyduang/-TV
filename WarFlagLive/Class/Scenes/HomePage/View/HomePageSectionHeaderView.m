//
//  HomePageSectionHeaderView.m
//  WarFlagLive
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HomePageSectionHeaderView.h"

@implementation HomePageSectionHeaderView

{
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, (50*kDeviceFactor-25*kDeviceFactor)/2, 5, 25*kDeviceFactor)];
    line.backgroundColor = kColor_Main_Color;
    [self addSubview:line];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(line.frame.origin.x+line.frame.size.width+10, 0, 200, 50*kDeviceFactor)];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor  =  [UIColor blackColor];
    [self addSubview:label];
}


- (void)resetTitle:(HomeListModel *)model{
    label.text =model.title;
}


@end
