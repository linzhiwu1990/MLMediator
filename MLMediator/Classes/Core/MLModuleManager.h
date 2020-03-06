//
//  MLModuleManager.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import <Foundation/Foundation.h>
#import "MLModuleProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@class MLMediator;
@protocol MLModuleDelegateProtocol;


/*
    模块管理员：用于管理模块生命周期、创建模块、注册模块、注销模块。
    不处理对外提供的服务，不提供对外获取的模块的方法，只有事件分发, 每个模块的服务自己模块提供，这里只处理全局
 */
@interface MLModuleManager : NSObject <MLModuleLifecycleProtocol, MLModuleViewLifecycleProtocol>

/** 单例 */
//+ (instancetype)sharedInstance;

/** 注册单个模块 */
- (void)registerModule:(Class)moduleClass;

/** 注销单个模块 */
- (void)unRegisterModule:(Class)moduleClass;

/** plist文件批量注册模块 */
- (void)registerModulesWithPlistFileName:(NSString *)fileName;

/** 注销所有模块 */
- (void)unRegisterAllModules;

@end

NS_ASSUME_NONNULL_END
