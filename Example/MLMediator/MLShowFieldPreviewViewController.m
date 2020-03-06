//
//  MLShowFieldPreviewViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/27.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLShowFieldPreviewViewController.h"
#import "TXLiteAVSDK_Professional/TXLiteAVSDK.h"
#import <MLMediator/MLMediator.h>


@interface MLShowFieldPreviewViewController () <TXLivePlayListener, MLPlayerServiceProtocol>

@property (nonatomic, strong) UIView *previewView;

@property (nonatomic, strong) TXLivePlayer *player;

@end

@implementation MLShowFieldPreviewViewController

#pragma mark - 生命周期

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.previewView];

    [self.player setupVideoWidget: [UIScreen mainScreen].bounds containView:self.previewView insertIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.previewView.frame = self.view.bounds;
}

#pragma mark - 代理

-(void) onPlayEvent:(int)EvtID withParam:(NSDictionary*)param {

    NSLog(@"播放器 - ID = %d %@", EvtID, param);
}

#pragma mark - 实现协议

- (void)startPlay:(NSString *)url {
    [self.player startPlay:url type:PLAY_TYPE_VOD_FLV];
}

- (void)stopPlay {
    [self.player stopPlay];
}

#pragma mark - getter

- (UIView *)previewView {
    if (_previewView == nil) {
        _previewView = [[UIView alloc] init];
    }
    return _previewView;
}

- (TXLivePlayer *)player {
    if (_player == nil) {
        _player = [[TXLivePlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}

@end
