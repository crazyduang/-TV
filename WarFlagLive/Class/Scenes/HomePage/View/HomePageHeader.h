//
//  HomePageHeader.h
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HomeListModel.h"
#import "HomePageSectionHeaderView.h"
#import "CycleScrollView.h"
#import "AdModel.h"
#import "RoomDetailVC.h"

@interface HomePageHeader : UICollectionReusableView

@property (nonatomic, weak) UIViewController *viewController;

- (void)resetArray:(NSArray *)array;

- (void)resetTitle:(HomeListModel*)model;



@end
