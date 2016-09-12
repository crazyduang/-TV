//
//  LiveVC.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LiveVC.h"

@interface LiveVC ()

@end

@implementation LiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBar];
}

#pragma mark 设置导航条
- (void)setNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.hidden = YES;
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = kColor_Main_Color;
    topView.frame=CGRectMake(0, 0, kScreenWidth, kMarginTopHeight);
    [self.view addSubview:topView];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 60, 32)];
    leftImg.image = [UIImage imageNamed:@"nav_home_logo@2x.png"];
    leftImg.hidden=NO;
    [topView addSubview:leftImg];
    
    UIImageView *centerImg  = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20+(44-26)/2, kScreenWidth-120, 26)];
    centerImg.image = [UIImage setNewImage:@"nav_home_search@2x.png"];
    centerImg.hidden=NO;
    [topView addSubview:centerImg];
    
    UIButton *saoBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [saoBtn setImage:[UIImage imageNamed:@"nav_home_sao@2x.png"] forState:UIControlStateNormal];
    saoBtn.frame = CGRectMake(kScreenWidth-40, 20, 44, 44);
    saoBtn.hidden=NO;
    [topView addSubview:saoBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
