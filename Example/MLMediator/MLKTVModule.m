//
//  MLKTVModule.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/26.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLKTVModule.h"
#import "MLKTVModuleService.h"
#import "MLKTVMessageHandler.h"

@interface MLKTVModule ()


@end

@implementation MLKTVModule


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
    [[MLMediator sharedInstance] registerClass:[MLKTVModuleService class] forProtocol:@protocol(MLKTVModuleServiceProtocol)];
}

/** 模块初始化：一般在这里做初始化操作 */
- (void)moduleInit {
    MLDebugLog();
    
    [[MLMediator sharedInstance] registerEvent:MLDidReceiveIMMessageEvent module:self selector:@selector(roomDidReceiveIMMessage:)];
    [[MLMediator sharedInstance] registerEvent:MLDidUpdateConfigEvent module:self selector:@selector(roomDidUpdateConfig:)];
    
    [[MLMediator sharedInstance] registerEvent:MLBusinessAEvent module:self selector:@selector(receiveBusinessAEvent)];
    
    [[MLMediator sharedInstance] registerMessageID:@"message1" forClass:[MLKTVMessageHandler class]];
    [[MLMediator sharedInstance] registerMessageID:@"message2" forClass:[MLKTVMessageHandler class]];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf sendEvent];
    });
}

- (void)sendEvent {
    [[MLMediator sharedInstance] triggerEvent:MLBusinessAEvent];
    [[MLMediator sharedInstance] distributeMessageID:@"message1" params:nil];
    [[MLMediator sharedInstance] distributeMessageID:@"message2" params:nil];
}

/** 模块将要被注销前会调用 */
- (void)moduleWillUnRegister {
    MLDebugLog();
}

#pragma mark View生命周期

/** sourceVC的view已经加载：一般在这里做初始化跟UI相关操作。*/
- (void)viewDidLoad {
    MLDebugLog();
}

- (void)viewDidLayoutSubviews {
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)viewDidDisappear:(BOOL)animated {
}

#pragma mark - 私有方法

- (void)receiveBusinessAEvent {
    MLDebugLog();
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


@end
