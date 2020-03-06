//
//  MLLiveMediaModule.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiveMediaModule.h"
#import <MLMediator/MLMediator.h>
#import "MLLivePreviewViewController.h"

@interface MLLiveMediaModule ()

@property (nonatomic, strong) UIViewController<MLPushServiceProtocol> *livePreviewVC;
@end

@implementation MLLiveMediaModule


#pragma mark - 生命周期

/** 模块被创建时调用：最好不要在这里初始化、此处会根据注册的顺序马上调用 */
- (instancetype)init {
    if (self = [super init]){
        MLDebugLog();
    }
    return self;
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 协议实现

#pragma mark 模块配置

/** 模块层级：不实现默认MLModuleLevelLow */
- (MLModuleLevel)moduleLevel {
    return MLModuleLevelLow;
}

// 模块优先级：越大优先级越高，分发事件时会根据这个优先级调用，用于解决模块之间初始化的依赖关系
- (NSInteger)modulePriority {
    return 80;
}

#pragma mark 模块生命周期

/** 模块配置：初始化之前调用 此处模块都注册完毕，会根据模块的层级，和优先级顺序调用各个模块  */
- (void)moduleSetup {
    MLDebugLog();
    
    /* 注册服务 */
    [[MLMediator sharedInstance] registerClass:[MLLivePreviewViewController class] forProtocol:@protocol(MLPushServiceProtocol)];
}

/** 模块初始化：一般在这里做初始化操作 */
- (void)moduleInit {
    MLDebugLog();
    
    [[MLMediator sharedInstance] registerEvent:MLDidReceiveIMMessageEvent module:self selector:@selector(roomDidReceiveIMMessage:)];
    [[MLMediator sharedInstance] registerEvent:MLDidUpdateConfigEvent module:self selector:@selector(roomDidUpdateConfig:)];
}

/** 模块将要被注销前会调用 */
- (void)moduleWillUnRegister {
    MLDebugLog();
    
    [self.livePreviewVC destroy];
}

#pragma mark View生命周期

/** sourceVC的view已经加载：一般在这里做初始化跟UI相关操作。*/
- (void)viewDidLoad {
    MLDebugLog();
    
    [[MLMediator sharedInstance].sourceVC addChildViewController:self.livePreviewVC];
    [[MLMediator sharedInstance].sourceVC.view addSubview:self.livePreviewVC.view];
    [self.livePreviewVC didMoveToParentViewController:[MLMediator sharedInstance].sourceVC];
}

- (void)viewDidLayoutSubviews {
    self.livePreviewVC.view.frame = [MLMediator sharedInstance].sourceVC.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)viewDidDisappear:(BOOL)animated {
}

#pragma mark 房间业务

// 直播间配置更新调用
- (void)roomDidUpdateConfig:(NSDictionary *)config {
    MLDebugLog();
}

// 接收到IM时调用。
- (void)roomDidReceiveIMMessage:(NSDictionary *)message {
    MLDebugLog();
}

#pragma mark - getter

- (id<MLPushServiceProtocol>)livePreviewVC {
    if (_livePreviewVC == nil) {
        _livePreviewVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLPushServiceProtocol)];
    }
    return _livePreviewVC;
}


@end
