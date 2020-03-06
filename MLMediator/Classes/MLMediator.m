//
//  MLMediator.m
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import "MLMediator.h"
#import "MLEventManager.h"
#import "MLMessageManager.h"

@interface MLMediator ()

@property (nonatomic, strong) MLModuleManager *moduleManager;

@property (nonatomic, strong) MLServiceManager *serviceManager;

@property (nonatomic, strong) MLEventManager *eventManager;

@property (nonatomic, strong) MLMessageManager *messageManager;

@end

@implementation MLMediator

#pragma mark - 生命周期

+ (instancetype)sharedInstance {
    static MLMediator *_sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MLMediator alloc] init];
    });
    return _sharedInstance;
}

- (void)dealloc {
    MLDebugLog(@"释放");
}

#pragma mark - 公共方法

- (void)destroyAll {
    [self unRegisterAllModules];
    [self unRegisterAllService];
    [self unRegisterAllEvent];
    [self unRegisterAllMessage];
    
    self.config = nil;
    self.content = nil;
    self.sourceVC = nil;
    self.moduleManager = nil;
    self.serviceManager = nil;
    self.eventManager = nil;
    self.messageManager = nil;
}

#pragma mark 模块相关

/** 注册单个模块 */
- (void)registerModule:(Class)moduleClass {
    [self.moduleManager registerModule:moduleClass];
}

/** 注销单个模块 */
- (void)unRegisterModule:(Class)moduleClass {
    [self.moduleManager unRegisterModule:moduleClass];
    
}

/** plist文件批量注册模块 */
- (void)registerModulesWithPlistFileName:(NSString *)fileName {
    [self.moduleManager registerModulesWithPlistFileName:fileName];
}

/** 注销所有模块 */
- (void)unRegisterAllModules {
    [self.moduleManager unRegisterAllModules];
}


#pragma mark 服务相关

/** plist文件批量注册服务 */
- (void)registerServiceWithPlistFileName:(NSString *)fileName {
    [self.serviceManager registerServiceWithPlistFileName:fileName];
}

/** 通过类协议 注册 服务 */
- (void)registerClass:(Class)serviceClass forProtocol:(Protocol *)serviceProtocol {
    [self.serviceManager registerClass:serviceClass forProtocol:serviceProtocol];
}

/** 通过协议获取对应的类 */
- (Class)classFromProtocol:(Protocol *)serviceProtocol {
    return [self.serviceManager classFromProtocol:serviceProtocol];
}

/** 通过协议获取对应的实例对象 */
- (id)instanceFromProtocol:(Protocol *)serviceProtocol {
     return [self.serviceManager instanceFromProtocol:serviceProtocol];
}

/** 移除对应协议的实力对象*/
- (void)removeInstanceWithProtocolName:(NSString *)protocolName {
    [self.serviceManager removeInstanceWithProtocolName:protocolName];
}

/** 注销所有服务 */
- (void)unRegisterAllService {
    [self.serviceManager  unRegisterAllService];
}

#pragma mark - 事件相关

/** 注册模块事件 */
- (void)registerEvent:(NSInteger)eventID module:(id<MLModuleProtocol>)module selector:(SEL)selector {
    [self.eventManager registerEvent:eventID module:module selector:selector];
}

/** 触发模块事件：带参数 */
- (void)triggerEvent:(NSInteger)eventID params:(NSDictionary *)params {
    [self.eventManager triggerEvent:eventID params:params];
}

/** 触发模块事件 不带参数*/
- (void)triggerEvent:(NSInteger)eventID {
    [self.eventManager triggerEvent:eventID];
}

/** 注销单个模块的所有eventI*/
- (void)unRegisterAllEventForModule:(id<MLModuleProtocol>)module {
    [self.eventManager unRegisterAllEventForModule:module];
}

/** 注销所有模块所有eventI: 不对外开放此方法, 每个模块事件自己注销，*/
- (void)unRegisterAllEvent {
    [self.eventManager unRegisterAllEvent];
}


#pragma mark - 消息Message中心

/** 注册IM消息 */
- (void)registerMessageID:(NSString *)messageID forClass:(Class)className {
    [self.messageManager registerMessageID:messageID forClass:className];
}

- (void)distributeMessageID:(NSString *)messageID {
    [self.messageManager distributeMessageID:messageID];
}

- (void)distributeMessageID:(NSString *)messageID params:(nullable NSDictionary *)params {
    [self.messageManager distributeMessageID:messageID params:params];
}

- (void)unRegisterAllMessage {
    [self.messageManager unRegisterAllMessage];
}


#pragma mark - 私有方法


#pragma mark - getter

- (MLModuleManager *)moduleManager {
    if (_moduleManager == nil) {
        _moduleManager = [[MLModuleManager alloc] init];
    }
    return _moduleManager;
}

- (MLServiceManager *)serviceManager {
    if (_serviceManager == nil) {
        _serviceManager = [[MLServiceManager alloc] init];
    }
    return _serviceManager;
}

- (MLEventManager *)eventManager {
    if (_eventManager == nil) {
        _eventManager = [[MLEventManager alloc] init];
    }
    return _eventManager;
}

- (MLMessageManager *)messageManager {
    if (_messageManager == nil) {
        _messageManager = [[MLMessageManager alloc] init];
    }
    return _messageManager;
}

- (MLMediatorContext *)content {
    if (_content == nil) {
        _content = [[MLMediatorContext alloc] init];
    }
    return _content;
}

- (MLConfiguration *)config {
    if (_config == nil) {
        _config = [[MLConfiguration alloc] init];
    }
    return _config;
}

@end
