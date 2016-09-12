//
//  HomePageHeader.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HomePageHeader.h"


@interface HomePageHeader ()

{
    HomePageSectionHeaderView *sectionView;
}

@property (nonatomic, strong) CycleScrollView *mainScorllView;

@end

@implementation HomePageHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}



- (void)addSubviews{
    sectionView= [[HomePageSectionHeaderView alloc]initWithFrame:CGRectMake(0, 170*kDeviceFactor, kScreenWidth, 50*kDeviceFactor)];
    [self addSubview:sectionView];
}

- (void)resetTitle:(HomeListModel *)model{
    [sectionView resetTitle:model];
}

- (void)resetArray:(NSArray *)array{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170*kDeviceFactor)];
        AdModel *model = obj;
        [img setImageWithURL:[NSURL URLWithString: model.spic] placeholderImage:[UIImage imageNamed:@""]];
        [viewsArray addObject:img];
        
    }];
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170*kDeviceFactor) animationDuration:2];
    
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
//        RoomDetailVC  *rvc = [[RoomDetailVC alloc]initWithRoomModel:((AdModel *)[array objectAtIndex:pageIndex]).room];
//        [self.viewController.navigationController pushViewController:rvc animated:YES];
        
        NSLog(@"点击了第%ld个",pageIndex);
    };
    [self addSubview:self.mainScorllView];
    
}



@end
