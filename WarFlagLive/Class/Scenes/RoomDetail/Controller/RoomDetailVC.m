//
//  RoomDetailVC.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RoomDetailVC.h"



#define  kHeight kScreenWidth*9/16
@interface RoomDetailVC ()

{
    BOOL _played;
    NSString *totalTime;
    NSDateFormatter *dataFormatter;
    NavgationView *navView;
    CATransform3D myTransform;
    Lists *listsModel;
    RoomModel *roomModel;
    NSString *_vid;
}


@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) PlayerView *playerView;

@property (nonatomic, strong) UIButton *swtichBtn;

@end

@implementation RoomDetailVC





- (instancetype)initWithVideoId:(NSString *)vid{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _vid = vid;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor blackColor];
    [self creatBasicConfig];
    [self creatNav];
    [self testUrl];
}


- (void)creatBasicConfig{
    self.playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kHeight)];
//    self.playerView.backgroundColor = [UIColor redColor];
    myTransform = self.playerView.layer.transform;
    [self.view addSubview:self.playerView];
    
    self.swtichBtn = [UIButton ButtonWithRect:CGRectMake(kScreenWidth-44, kHeight-10, 44, 44) title:@"" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(swtichAction:) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [self.swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:self.swtichBtn];
    
}
#pragma mark 切换全屏按钮
- (void)swtichAction:(UIButton *)sender{
    self.playerView.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
    navView.frame = CGRectMake(0, 0, kScreenHeight, 44);
    self.swtichBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
        self.playerView.layer.transform = transform;
        self.playerView.center = self.view.center;
        
        navView.layer.transform = transform;
        navView.center = CGPointMake(kScreenWidth-24, self.view.center.y);
        
    } completion:^(BOOL finished) {
        self.playerView.center = self.view.center;
    }];
}

#pragma mark 设置返回按钮
- (void)creatNav{
    navView = [[NavgationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) viewController:self];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    navView.center = CGPointMake(self.view.center.x, 42);
}

- (void)customBack{

    
    if (navView.frame.size.width == 44) {
        NSLog(@"全屏切换到小屏");
        _playerView.frame = CGRectMake(0, 20, kHeight, kScreenWidth);
        navView.frame = CGRectMake(0, 0, 44, kScreenWidth);
        [UIView animateWithDuration:0.3 animations:^{
            self.playerView.layer.transform = myTransform;
            self.playerView.center = CGPointMake(kScreenWidth/2, 20+kHeight/2);
            
            navView.layer.transform = myTransform;
            navView.center = CGPointMake(self.view.center.x, 42);
            
            self.swtichBtn.alpha = 0;
        } completion:^(BOOL finished) {
            self.playerView.center = self.view.center;
            self.swtichBtn.alpha = 1;
            self.swtichBtn.hidden = NO;
            self.playerView.center = CGPointMake(kScreenWidth/2, 20+kHeight/2);
        }];
    } else {
        NSLog(@"退出观看");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 设置播放数据源
- (void)testUrl{
    NSString *strUrl;
    if (listsModel) {
        strUrl = [NSString stringWithFormat:@"http://wshdl.load.cdn.zhanqi.tv/zqlive/%@.flv?get_url=1", listsModel.videoId];
    } else if (roomModel) {
        strUrl = [NSString stringWithFormat:@"http://wshdl.load.cdn.zhanqi.tv/zqlive/%@.flv?get_url=1", roomModel.videoIdKey];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"Httperror:%@%ld", connectionError.localizedDescription, connectionError.code);
        } else {
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HttpResponseCode:%ld", responseCode);
            NSLog(@"HttpResponseBody %@",responseString);
        }
    }];
    
    [self playVideo];
}

- (void)playVideo{
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@%@.m3u8", HLS_URL, _vid]];
    filePath = (NSMutableString *)[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl = [NSURL URLWithString:filePath];
    NSLog(@"videoUrl == %@", videoUrl);
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil]; // 监听status 属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = self.player;
    [self.playerView.player play];
    
}

#pragma mark KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
        } else if (playerItem.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}

- (void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
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
