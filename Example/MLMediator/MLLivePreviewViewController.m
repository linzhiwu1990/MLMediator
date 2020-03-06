//
//  MLLivePreviewViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLivePreviewViewController.h"
#import <TXLivePush.h>
#import <MLMediator/MLMediator.h>



@interface MLLivePreviewViewController () <TXLivePushListener>

@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) TXLivePush *livePush;
@property (nonatomic, assign, getter=isAppBackground) BOOL appBackground;

@property (nonatomic, strong) UILabel *countDownLabel;

@property (nonatomic, assign, getter=isMute) BOOL mute;
@property (nonatomic, assign, getter=isMirror) BOOL mirror;
@property (nonatomic, assign, getter=isBeauty) BOOL beauty;
@property (nonatomic, assign, getter=isLandscape) BOOL landscape;

@end

@implementation MLLivePreviewViewController

#pragma mark - 生命周期

- (void)dealloc {
    MLDebugLog();
}

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mirror = YES;
    self.mute = NO;
    self.beauty = NO;
    self.landscape = NO;
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.previewView atIndex:0];
    [self.view addSubview:self.countDownLabel];
    self.countDownLabel.bounds = CGRectMake(0, 0, 105, 211);
    self.countDownLabel.center = self.view.center;

    [self startPreview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self runCountDownAnimation:3];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.previewView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - 事件处理

#pragma mark 通知

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];

    if (self.livePush.isPublishing) {
        self.appBackground = YES;
        [self.livePush pausePush];
    }
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    if (self.appBackground == YES) {
        [self.livePush resumePush];
        self.appBackground = NO;
    }
}

#pragma mark - TXLivePushListener

- (void)onPushEvent:(int)EvtID withParam:(NSDictionary *)param {
//    MLDebugLog(@"pushEvent = %d", EvtID);
}

- (void)onNetStatus:(NSDictionary *)param {
    
}

#pragma mark - 私有方法

- (void)runCountDownAnimation:(NSInteger)countDown {
    self.countDownLabel.text = [NSString stringWithFormat:@"%ld", (long)countDown];
    
    if (countDown > 0) {
        self.view.userInteractionEnabled = NO;

        [UIView animateWithDuration:1.0 animations:^{
            self.countDownLabel.transform = CGAffineTransformMakeScale(0.4, 0.4);
        } completion:^(BOOL finished) {
            self.countDownLabel.transform = CGAffineTransformIdentity;
            [self runCountDownAnimation:countDown - 1];
        }];
    } else {
        self.countDownLabel.hidden = YES;
        self.view.userInteractionEnabled = NO;
        [self startPush:@"rtmp://54268.livepush.myqcloud.com/live/linzhiwu?txSecret=a4159c1afcc6a8fe3cf997ba9ce5595a&txTime=5E04D8FF"];
        
        // 显示装饰层
        id<MLLiveDecorateScrollVCServiceProtocol> decorateScrollVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLLiveDecorateScrollVCServiceProtocol)];
        [decorateScrollVC showDecorateLayerUI];
        
        // 请求开始直播的api，不然房间列表看不到。
    }
    
}

#pragma mark - 协议实现

- (void)startPreview {
    [self.livePush startPreview:self.previewView];
}

- (void)stopPreview {
    [self.livePush stopPreview];
}

- (void)startPush:(NSString *)urlString {
    [self.livePush startPush:urlString];
}

- (void)stopPush {
    [self.livePush stopPush];
}

- (void)destroy {
    [self stopPreview];
    [self stopPush];
}

- (void)playBackgroundMusic:(NSString *)filePath {
    [self.livePush playBGM:filePath];
}

/** 切换视频清晰度 */
- (void)switchVideoQuality {
    
}

/** 切换美颜开关 */
- (void)switchBeauty {
    self.beauty = !self.beauty;
    if (self.beauty) {
        [self.livePush setBeautyStyle:BEAUTY_STYLE_NATURE beautyLevel:5 whitenessLevel:7 ruddinessLevel:5];
    } else {
        [self.livePush setBeautyStyle:BEAUTY_STYLE_NATURE beautyLevel:0 whitenessLevel:0 ruddinessLevel:0];
    }
}

/** 切换静音开关 */
- (void)swithMute {
    self.mute = !self.mute;
    [self.livePush setMute:self.mute];
}

/** 切换镜像开关 */
- (void)swithMirror {
    self.mirror = !self.mirror;
    [self.livePush setMirror:self.mirror];
}

/** 切换摄像头 */
- (void)switchCamera {
    [self.livePush switchCamera];
}

/** 切换屏幕方向 */
- (void)switchScreenOrientation {
    self.landscape = !self.landscape;
    if (self.landscape) {
        self.livePush.config.homeOrientation = HOME_ORIENTATION_RIGHT;
        [self.livePush setConfig:self.livePush.config];
        [self.livePush setRenderRotation:90];
    } else {
        self.livePush.config.homeOrientation = HOME_ORIENTATION_DOWN;
        [self.livePush setConfig:self.livePush.config];
        [self.livePush setRenderRotation:0];
    }
}

#pragma mark - getter

- (UIView *)previewView {
    if (_previewView == nil) {
        _previewView = [[UIView alloc] init];
        _previewView.userInteractionEnabled = NO;
    }
    return _previewView;
}

- (TXLivePush *)livePush {
    if (_livePush == nil) {
        TXLivePushConfig *config = [[TXLivePushConfig alloc] init];
        _livePush = [[TXLivePush alloc] initWithConfig:config];
        _livePush.delegate = self;
    }
    return _livePush;
}

- (UILabel *)countDownLabel {
    if (_countDownLabel == nil) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.font = [UIFont systemFontOfSize:170];
        _countDownLabel.textColor = [UIColor whiteColor];
    }
    return _countDownLabel;
}

@end
