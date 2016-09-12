//
//  PlayerView.m
//  WarFlagLive
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}




@end
