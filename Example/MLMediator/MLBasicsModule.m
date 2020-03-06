//
//  MLBasicsModule.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/24.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLBasicsModule.h"
#import <MLMediator/MLMediator.h>
#import "MLBasicsModuleService.h"
#import "MLGiftService.h"
#import "MLSharePanelViewController.h"
#import "MLIMManager.h"
#import <TWMessageBarManager/TWMessageBarManager.h>


@interface MLBasicsModule () <MLModuleProtocol>

@end

@implementation MLBasicsModule

#pragma mark - 协议实现


#pragma mark 模块配置

- (MLModuleLevel)moduleLevel {
    return MLModuleLevelHigh;
}

- (NSInteger)modulePriority {
    return 1000;
}

#pragma mark 模块生命周期

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

/** 模块配置：初始化之前调用 此处模块都注册完毕，会根据模块的层级，和优先级顺序调用各个模块, 一般在这里注册协议  */
- (void)moduleSetup {
    MLDebugLog();
    
    [[MLMediator sharedInstance] registerClass:[MLBasicsModuleService class] forProtocol:@protocol(MLBasicsModuleServiceProtocol)];
    [[MLMediator sharedInstance] registerClass:[MLGiftService class] forProtocol:@protocol(MLGiftServiceProtocol)];
    [[MLMediator sharedInstance] registerClass:[MLSharePanelViewController class] forProtocol:@protocol(MLShareServiceProtocol)];
    [[MLMediator sharedInstance] registerClass:[MLIMManager class] forProtocol:@protocol(MLIMServiceProtocol)];
}

/** 模块初始化：一般在这里做初始化操作 */
- (void)moduleInit {
    MLDebugLog();
    
    id<MLIMServiceProtocol> imManager = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLIMServiceProtocol)];
    [imManager connect:@"此处填写url地址"];
    
    [[MLMediator sharedInstance] registerEvent:MLDidReceiveIMMessageEvent module:self selector:@selector(roomDidReceiveIMMessage:)];
    [[MLMediator sharedInstance] registerEvent:MLDidUpdateConfigEvent module:self selector:@selector(roomDidUpdateConfig:)];

}

- (void)moduleWillUnRegister {
    MLDebugLog();
    id<MLIMServiceProtocol> imManager = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLIMServiceProtocol)];
    [imManager disconnect];
}

#pragma mark 房间业务

// 直播间配置更新调用
- (void)roomDidUpdateConfig:(NSDictionary *)config {
    MLDebugLog();
}

// 接收到IM时调用。
- (void)roomDidReceiveIMMessage:(NSDictionary *)message {
    MLDebugLog();
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"基础模块" description:[NSString stringWithFormat:@"收到IM消息 = %@", message[@"text"]] type:TWMessageBarMessageTypeInfo];

}

#pragma mark View生命周期

/** sourceVC的view已经加载：一般在这里做初始化跟UI相关操作。*/
- (void)viewDidLoad {
    MLDebugLog();
    [MLMediator sharedInstance].sourceVC.view.backgroundColor = [UIColor blackColor];
    
    [self requestRoomConfig];
}

- (void)viewDidLayoutSubviews {
}

- (void)viewWillAppear:(BOOL)animated {
    [[MLMediator sharedInstance].sourceVC.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)viewWillDisappear:(BOOL)animated {
    [[MLMediator sharedInstance].sourceVC.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    
}

#pragma mark - 网络请求

- (void)requestRoomConfig {
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟2秒后请求网络成功
        [weakSelf updateConfig];  // 所有延迟black调用MLMediator的都要用weakSelf做中转
    });
}

- (void)updateConfig {
    NSMutableDictionary *config = [NSMutableDictionary dictionary];
    config[@"text"] = @"config信息";
    MLDebugLog(@"请求配置成功");
    [[MLMediator sharedInstance] triggerEvent:MLDidUpdateConfigEvent];
}

#pragma mark - getter

@end
