//
//  ZWModuleProtocol.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MLModuleLevel) {
    MLModuleLevelHigh = 0,
    MLModuleLevelLow = 1
};

@protocol MLModuleLifecycleProtocol;
@protocol MLModuleViewLifecycleProtocol;
@protocol MLModuleConfigProtocol;

@class MLMediator;

/** MLModuleProtocol中的协议都会调用到每个模块  */
@protocol MLModuleProtocol < MLModuleLifecycleProtocol, MLModuleViewLifecycleProtocol, MLModuleConfigProtocol>

@required
@property (nonatomic, weak) MLMediator *mediator;

@end

/** 模块生命周期协议 */
@protocol MLModuleLifecycleProtocol <NSObject>

@optional;

/** 设置: 一般在这里注册本模块的服务 */
- (void)moduleSetup;

/** 初始化：先设置后初始化*/
- (void)moduleInit;

/** 模块被注销前会调用 */
- (void)moduleWillUnRegister;

@end

/** 模块View生命周期协议 */
@protocol MLModuleViewLifecycleProtocol <NSObject>

@optional;

- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLayoutSubviews;

@end

@protocol MLModuleConfigProtocol <NSObject>

@optional;

/** 模块层级：不实现默认MLModuleLevelLow */
- (MLModuleLevel)moduleLevel;

// 模块优先级：越大优先级越高，分发事件时会根据这个优先级调用，用于解决模块之间初始化的依赖关系
- (NSInteger)modulePriority;

@end

NS_ASSUME_NONNULL_END
