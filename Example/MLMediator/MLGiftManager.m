//
//  MLGiftManager.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLGiftManager.h"
#import <MLMediator/MLMediator.h>
#import "MLGift.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import <AVFoundation/AVFoundation.h>

@interface MLGiftManager ()

/** 播放器 */
@property (nonatomic, strong, nullable) AVPlayer *player;

/** 当前播放器的图层 */
@property (nonatomic, strong, nullable) AVPlayerLayer *currentPlayerLayer;

/** 当前播放选项 */
@property (nonatomic, strong, nullable) AVPlayerItem *currentPlayerItem;

@property (nonatomic, assign, getter=isPlaying) BOOL playing;

@end

@implementation MLGiftManager

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    MLDebugLog();

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)showGiftAnimation:(MLGift *)gift {
    MLDebugLog(@"显示礼物动画");
    
    NSString *desc = [NSString stringWithFormat:@"播放<%@> 动画 ", gift.name];
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"礼物模块" description:desc type:TWMessageBarMessageTypeSuccess];
    [self playAnimation];
}

- (void)playAnimation {
    if (self.isPlaying) {
        return;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"phoenix_ice_HD" withExtension:@"mp4"];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    self.currentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.currentPlayerLayer.frame = CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 300);
    self.currentPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [[MLMediator sharedInstance].sourceVC.view.layer addSublayer:self.currentPlayerLayer];
    
    [self.player play];
    self.playing = YES;
}

- (void)playerItemDidPlayToEndTimeNotification:(NSNotification *)notification {
    [self.currentPlayerLayer removeFromSuperlayer];
    self.playing = NO;
}

@end
