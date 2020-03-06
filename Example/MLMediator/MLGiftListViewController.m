//
//  MLGiftListViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLGiftListViewController.h"
#import "MLGiftPanelContainerView.h"
#import "MLGiftManager.h"
#import "MLGift.h"
#import <MLMediator/MLMediator.h>

@interface MLGiftListViewController () <MLGiftPanelContainerViewDelegate>

@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) MLGiftPanelContainerView *containerView;
@property (nonatomic, strong) MLGiftManager *giftManager;

@end

@implementation MLGiftListViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:0 green: 0 blue:0 alpha:0.25];
    
    [self.view addSubview:self.bgButton];
    [self.view addSubview:self.containerView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.bgButton.frame = self.view.bounds;
    
    CGFloat containerViewW = self.view.frame.size.width;
    CGFloat containerViewH = self.view.frame.size.height * 0.3;
    CGFloat containerViewX = 0;
    CGFloat containerViewY = self.view.frame.size.height - containerViewH;
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 事件处理
- (void)clickBgButton {
    [self dismiss];
}

#pragma mark - 代理

#pragma mark MLGiftPanelContainerViewDelegate
- (void)giftPanelContainerView:(MLGiftPanelContainerView *)containerView  didSelectItemWithGift:(MLGift *)gift {
    [self sendGift:gift];
}

#pragma mark - 公共方法

- (void)show {
    UIViewController *sourceVC = [MLMediator sharedInstance].sourceVC;
    [sourceVC addChildViewController:self];
    [sourceVC.view addSubview:self.view];
    self.view.frame = sourceVC.view.bounds;
    [sourceVC didMoveToParentViewController:sourceVC];
    
    id<MLDecorateVCServiceProtocol> decorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
    [decorateVC hideBottomBar];
}

#pragma mark - 私有方法

- (void)sendGift:(MLGift *)gift {
    // 异步发送请求，
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 发送礼物成功
        [weakSelf showGift:gift];
    });
}

- (void)showGift:(MLGift *)gift {
    [self.giftManager showGiftAnimation:gift]; // 显示礼物动画
    id<MLDecorateVCServiceProtocol> decorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
    [decorateVC showGiftMessage:gift]; // 聊聊里面显示发送礼物消息。
}

- (void)dismiss {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    
    id<MLDecorateVCServiceProtocol> decorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
    [decorateVC showBottomBar];
}

#pragma mark - getter

- (MLGiftPanelContainerView *)containerView {
    if (_containerView == nil) {
        _containerView = [[MLGiftPanelContainerView alloc] init];
        _containerView.delegate = self;
    }
    return _containerView;
}

- (UIButton *)bgButton {
    if (_bgButton == nil) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.adjustsImageWhenHighlighted = NO;
        [_bgButton addTarget:self action:@selector(clickBgButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (MLGiftManager *)giftManager {
    if (_giftManager == nil) {
        _giftManager = [[MLGiftManager alloc] init];
    }
    return _giftManager;
}

@end
