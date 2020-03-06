//
//  MLMediator.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import <Foundation/Foundation.h>
#import "MLModuleManager.h"
#import "MLModuleProtocol.h"
#import "MLModuleDelegateProtocol.h"
#import "MLServiceManager.h"
#import "MLServiceProtocol.h"
#import "MLMediatorContext.h"
#import "MLConfiguration.h"
#import "MLMediatorMacro.h"
#import "MLServices.h"
#import "MLModuleEvent.h"
#import "MLMessageProtocol.h"

@interface MLMediator : NSObject

/** 源控制器（当前为房间控制器）： 为了兼容老版本，用于使用MLMediator模块和和没使用MLMediator模块之间的通讯 */
@property (nonatomic, weak) UIViewController<MLModuleDelegateProtocol> *sourceVC;

/** 上下文：外部传入，用于保存全局信息 */
@property (nonatomic, strong) MLMediatorContext *content;

/** 配置信息：用于存放框架相关的配置信息，不存储跟业务相关信息 */
@property (nonatomic, strong) MLConfiguration *config;

/** 模块管理员：暴露出来是为了实现事件分发 */
@property (nonatomic, strong, readonly) MLModuleManager *moduleManager;

/** 单例 */
+ (instancetype)sharedInstance;

/** 清除所有数据、模块和服务、事件 */
- (void)destroyAll;

/*************** 模块相关  ******************/

/** 注册单个模块 */
- (void)registerModule:(Class)moduleClass;

/** 注销单个模块 */
- (void)unRegisterModule:(Class)moduleClass;

/** plist文件批量注册模块 */
- (void)registerModulesWithPlistFileName:(NSString *)fileName;

/** 注销所有模块 */
- (void)unRegisterAllModules;


/*************** 服务相关  ******************/

/** plist文件批量注册服务 */
- (void)registerServiceWithPlistFileName:(NSString *)fileName;

/** 通过类协议 注册 服务 */
- (void)registerClass:(Class)serviceClass forProtocol:(Protocol *)serviceProtocol;

/** 通过协议获取对应的类 */
- (Class)classFromProtocol:(Protocol *)serviceProtocol;

/** 通过协议获取对应的实例对象 */
- (id)instanceFromProtocol:(Protocol *)serviceProtocol;

/** 移除对应协议的实例对象*/
- (void)removeInstanceWithProtocolName:(NSString *)protocolName;

/** 注销所有服务 */
- (void)unRegisterAllService;


///*************** 模块事件中心 ( 会根据模块的优先级发送模块事件） ******************/

/** 注册模块事件 */
- (void)registerEvent:(NSInteger)eventID module:(id<MLModuleProtocol>)module selector:(SEL)selector;

/** 触发模块事件：带参数 */
- (void)triggerEvent:(NSInteger)eventID params:(NSDictionary *)params;

/** 触发模块事件 不带参数*/
- (void)triggerEvent:(NSInteger)eventID;

/** 注销单个模块的所有eventI：一般在每个模块的moduleWillUnRegister方法中调用此方法，释放本模块所有事件、不然的话会到所有模块都释放的时候destroyAll时才统一释放*/
- (void)unRegisterAllEventForModule:(id<MLModuleProtocol>)module;

/** 注销所有模块所有eventI: 不对外开放此方法, 每个模块事件自己注销，*/
//- (void)unRegisterAllEvent;


///*************** Message中心（用于做IM消息转发，发送顺序和模块的优先级没有关系）   ******************/

/** 注册IM消息 */
- (void)registerMessageID:(NSString *)messageID forClass:(Class)className;

- (void)distributeMessageID:(NSString *)messageID;
- (void)distributeMessageID:(NSString *)messageID params:(nullable NSDictionary *)params;


@end

