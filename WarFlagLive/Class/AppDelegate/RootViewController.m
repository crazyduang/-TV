//
//  RootViewController.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RootViewController.h"
#import "HomePageVC.h"
#import "LiveVC.h"
#import "GameVC.h"
#import "MineVC.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
}

- (void)initSubviews{
    HomePageVC *homePageVC = (HomePageVC*)[self viewControllerWithKey:@"tab_homepage"];
    [self setTabbarWithController:homePageVC key:@"tab_homepage"];
    
    LiveVC *liveVC = (LiveVC *)[self viewControllerWithKey:@"tab_live"];
    [self setTabbarWithController:liveVC key:@"tab_live"];
    
    GameVC *gameVC = (GameVC *)[self viewControllerWithKey:@"tab_game"];
    [self setTabbarWithController:gameVC key:@"tab_game"];
    
    MineVC *mineVC = (MineVC *)[self viewControllerWithKey:@"tab_mine"];
    [self setTabbarWithController:mineVC key:@"tab_mine"];
    
    self.viewControllers = @[homePageVC, liveVC, gameVC, mineVC];
}

- (UIViewController *)viewControllerWithKey:(NSString *)key {
    NSString *strClass = @"";
    NSDictionary *dict = @{
                           @"tab_homepage" : @"HomePageVC",
                           @"tab_live" : @"LiveVC",
                           @"tab_game" : @"GameVC",
                           @"tab_mine" : @"MineVC",
                           };
    if (key && key.length > 0) {
        strClass = [dict objectForKey:key];
        if (strClass && strClass.length > 0) {
            UIViewController *controller = [NSClassFromString(strClass) new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            return navigationController;
        }
    }
    return nil;
}


- (void)setTabbarWithController:(UIViewController *)controller key:(NSString *)key{
    NSDictionary *dict = @{
                            @"tab_homepage":@[@{@"title":@"首页", @"image":@"tabbar_home@2x.png", @"image_sel":@"tabbar_home_sel@2x.png"}],
                            @"tab_live":@[@{@"title":@"直播", @"image":@"tabbar_room@2x.png", @"image_sel":@"tabbar_rome_sel@2x.png"}],
                            @"tab_game":@[@{@"title":@"游戏", @"image":@"tabbar_game@2x.png", @"image_sel":@"tabbar_game_sel@2x.png"}],
                            @"tab_mine":@[@{@"title":@"我的", @"image":@"tabbar_me@2x.png", @"image_sel":@"tabbar_me_sel@2x.png"}]
                            };
    
    NSArray *arr = [dict objectForKey:key];
    NSDictionary *firstObj = [arr firstObject];

    UITabBarItem *customItem = [[UITabBarItem  alloc] initWithTitle:[firstObj objectForKey:@"title"] image:[UIImage imageNamed:[firstObj objectForKey:@"image"]] selectedImage:[UIImage imageNamed:[firstObj objectForKey:@"image_sel"]]];
    controller.tabBarItem = customItem;
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
