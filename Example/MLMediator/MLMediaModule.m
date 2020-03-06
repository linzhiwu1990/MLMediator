//
//  MLMediaModule.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/24.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLMediaModule.h"
#import <MLMediator/MLMediator.h>
#import "MLMediaModuleService.h"
#import "MLShowFieldPreviewViewController.h"

@interface MLMediaModule () <MLModuleProtocol>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIViewController<MLPlayerServiceProtocol> *showFieldVC;

@end

@implementation MLMediaModule

#pragma mark - 协议实现


#pragma mark 模块配置

- (NSInteger)modulePriority {
    return 90;
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

/** 模块配置：初始化之前调用 此处模块都注册完毕，会根据模块的层级，和优先级顺序调用各个模块  */
- (void)moduleSetup {
    MLDebugLog();
//    [[MLMediator sharedInstance] registerClass:[MLMediaModuleService class] forProtocol:@protocol(MLMediaModuleServiceProtocol)];
    [[MLMediator sharedInstance] registerClass:[MLShowFieldPreviewViewController class] forProtocol:@protocol(MLPlayerServiceProtocol)];
    
}

/** 模块初始化：一般在这里做初始化操作 */
- (void)moduleInit {
    MLDebugLog();
    
    [[MLMediator sharedInstance] registerEvent:MLDidReceiveIMMessageEvent module:self selector:@selector(roomDidReceiveIMMessage:)];
    [[MLMediator sharedInstance] registerEvent:MLDidUpdateConfigEvent module:self selector:@selector(roomDidUpdateConfig:)];
}

- (void)test {
    MLDebugLog(@"事件");
}

- (void)test2:(NSDictionary *)params {
    MLDebugLog(@"事件");

}

- (void)moduleWillUnRegister {
    MLDebugLog();
    [[MLMediator sharedInstance] unRegisterAllEventForModule:self];
    
    [self.showFieldVC stopPlay];
}

#pragma mark View生命周期

/** sourceVC的view已经加载：一般在这里做初始化跟UI相关操作。*/
- (void)viewDidLoad {
    MLDebugLog();
    
    [[MLMediator sharedInstance].sourceVC.view addSubview:self.bgImageView];
    
    [[MLMediator sharedInstance].sourceVC addChildViewController:self.showFieldVC];
    [[MLMediator sharedInstance].sourceVC.view addSubview:self.showFieldVC.view];
    [self.showFieldVC didMoveToParentViewController:[MLMediator sharedInstance].sourceVC];
    [self.showFieldVC startPlay:@"http://ali-pull.v.momocdn.com/momo/m_1564048415113d0b9db09ca651f9e1.flv?uniqtype=1&nettype=1&r=6c926609f1f0a21e0"];
}

- (void)viewDidLayoutSubviews {
    self.bgImageView.frame = [MLMediator sharedInstance].sourceVC.view.bounds;
    self.showFieldVC.view.frame = [MLMediator sharedInstance].sourceVC.view.bounds;
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

- (UIViewController<MLPlayerServiceProtocol> *)showFieldVC {
    if (_showFieldVC == nil) {
        _showFieldVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLPlayerServiceProtocol)];
    }
    return _showFieldVC;
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"room_bg"];
        
    }
    return _bgImageView;
}

@end
