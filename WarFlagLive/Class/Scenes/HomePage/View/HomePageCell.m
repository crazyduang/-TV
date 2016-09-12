//
//  HomePageCell.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HomePageCell.h"


@interface HomePageCell ()

{
    UIImageView *coverImage;
    UILabel *titleLabel;
    UIImageView *genderImage;
    UILabel *nickLabel;
    UIImageView *audienceImage;
    UILabel *audienceLabel;
}

@end

@implementation HomePageCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, (135-100)*kDeviceFactor/2, kScreenWidth/2-20, 100*kDeviceFactor)];
    [self addSubview:coverImage];
    UIView *shaowView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*kDeviceFactor-20,kScreenWidth/2-20 , 20)];
    shaowView.backgroundColor = [UIColor blackColor];
    shaowView.alpha = 0.5;
    [coverImage addSubview:shaowView];
    titleLabel = [UILabel labelWithRect:CGRectMake(0,  100*kDeviceFactor-20, kScreenWidth/2-20, 20) text:nil textColor:[UIColor whiteColor] fontSize:14 textAlignment:NSTextAlignmentLeft];
    [coverImage addSubview:titleLabel];
    
    genderImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, coverImage.frame.origin.y+coverImage.frame.size.height+5, 13, 13)];
    [self addSubview:genderImage];
    
    nickLabel = [UILabel labelWithRect:CGRectMake(genderImage .frame.origin.x+genderImage.frame.size.width+5, coverImage.frame.origin.y+coverImage.frame.size.height+5, 100, 13) text:nil textColor:[UIColor lightGrayColor] fontSize:10 textAlignment:NSTextAlignmentLeft];
    [self addSubview:nickLabel];
    
    audienceImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, coverImage.frame.origin.y+coverImage.frame.size.height+5, 13, 10)];
    audienceImage.image =[ UIImage imageNamed:@"room_audience@2x.png"];
    [self addSubview:audienceImage];
    
    audienceLabel = [UILabel labelWithRect:CGRectMake(genderImage .frame.origin.x+genderImage.frame.size.width+5, coverImage.frame.origin.y+coverImage.frame.size.height+5, 100, 13) text:nil textColor:[UIColor lightGrayColor] fontSize:10 textAlignment:NSTextAlignmentLeft];
    [self addSubview:audienceLabel];
}


- (void)resetModel:(Lists *)model{
    [coverImage setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@""]];
    titleLabel.text = model.title;
    if ([model.gender isEqualToString:@"1"]) {
        // 女
        genderImage.image = [UIImage imageNamed:@"icon_room_female@2x.png"];
    }else if ([model.gender isEqualToString:@"2"]){
        // 男
        genderImage.image = [UIImage imageNamed:@"icon_room_male@2x.png"];
    }
    nickLabel.text = model.nickname;
    NSString *online = model.online;
    if (online.length<=4) {
    }else{
        int   w = [online intValue]/10000;
        int   q  = [online intValue]%10000/1000;
        online =  [NSString stringWithFormat:@"%d. %d万", w,q];
        
    }
    audienceLabel.text = online;
    audienceLabel.frame= CGRectMake(coverImage.frame.size.width+coverImage.frame.origin.x-online.length *8, coverImage.frame.origin.y+coverImage.frame.size.height+5, online.length *8, 12);
    audienceImage.frame=CGRectMake(audienceLabel.frame.origin.x-20, coverImage.frame.origin.y+coverImage.frame.size.height+5, 13, 10);
}



@end
