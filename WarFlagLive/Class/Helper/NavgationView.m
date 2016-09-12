//
//  NavgationView.m
//  WarFlagLive
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "NavgationView.h"

@interface NavgationView ()

{
    UIButton *leftBtn;
}

@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation NavgationView

- (instancetype)initWithFrame:(CGRect)frame viewController:(id)viewController{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = viewController;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    leftBtn = [UIButton ButtonWithRect:CGRectMake(10, 0, 44, 44) title:@"返回" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(customBack) viewController:self.viewController titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [self addSubview:leftBtn];
}


@end
