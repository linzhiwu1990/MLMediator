//
//  MLServiceManager.m
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import "MLServiceManager.h"
#import "MLServiceProtocol.h"
#import "MLMediatorMacro.h"


static const NSString *kProtocolNameKey = @"protocolName";
static const NSString *kClassNameKey = @"className";


@interface MLServiceManager ()

/** 服务信息:用于存放类和协议的对应关系，key = 协议名，value = 类名 */
@property (nonatomic, strong) NSMutableDictionary *servicesInfo;

/** 对象服务信息：用于缓存实例对象和协议的对应关系，key = 协议名，value = 实例对象 */
@property (nonatomic, strong) NSMutableDictionary *instanceServicesInfo;

@property (nonatomic, strong) NSRecursiveLock *lock;


@end

@implementation MLServiceManager

#pragma mark - 生命周期

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 公共方法

#pragma mark  服务相关

/** plist文件批量注册服务 */
- (void)registerServiceWithPlistFileName:(NSString *)fileName {
    MLDebugLog(@"批量注册服务");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];

    // 过滤路径不存在情况
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return;
    }
    
    /** 获取服务列表 */
    NSArray *serviceList = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    /** 添加类协议 */
    [self.lock lock];
    for (NSDictionary *serviceDict in serviceList) {
        NSString *protocolName = [serviceDict objectForKey:kProtocolNameKey];
        NSString *className = [serviceDict objectForKey:kClassNameKey];
        if (protocolName.length > 0 && className.length > 0) {
            [self.servicesInfo setObject:className forKey:protocolName];
        }
    }
    [self.lock unlock];
    
    if (self.servicesInfo.allKeys.count > 0) {
        MLDebugLog(@"批量注册服务成功");

    }
    
}

/** 通过类协议 注册 服务 */
- (void)registerClass:(Class)serviceClass forProtocol:(Protocol *)serviceProtocol {
    MLDebugLog(@"注册服务 = %@", NSStringFromProtocol(serviceProtocol));
    
    /** 过滤异常 */
    NSParameterAssert(serviceClass != nil);
    NSParameterAssert(serviceProtocol != nil);
    
    if (![serviceClass conformsToProtocol:serviceProtocol]) {
        return;
    }
    
    /** 过滤已经存在的服务 */
    NSString *protocolName = NSStringFromProtocol(serviceProtocol);
    NSString *className = [self.servicesInfo objectForKey:protocolName];
    if ( className && className.length > 0) {
        return;
    } else {
        className = NSStringFromClass(serviceClass);
    }
    
    /** 添加类协议 */
    if (protocolName.length > 0 && className.length > 0) {
        [self.lock lock];
        [self.servicesInfo setObject:className forKey:protocolName];
        [self.lock unlock];
        MLDebugLog(@"注册服务成功 = %@", NSStringFromProtocol(serviceProtocol));
    }
}

/** 通过协议获取对应的类 */
- (Class)classFromProtocol:(Protocol *)serviceProtocol {
    NSString *protocolName = NSStringFromProtocol(serviceProtocol);
    [self.lock lock];
    NSDictionary *tempDict = [self.servicesInfo copy];
    [self.lock unlock];
    NSString *className = [tempDict objectForKey:protocolName];  // 检测下servicesInfo是否需要加锁
    if (className.length > 0) {
        return NSClassFromString(className);
    } else {
        return nil;
    }
}


#pragma mark 实例对象相关

- (id)instanceFromProtocol:(Protocol *)serviceProtocol {
    
    NSString *protocolName = NSStringFromProtocol(serviceProtocol);
    
    /** 检测协议是否被注册 */
    if (![self checkValidServiceProtocol:serviceProtocol]) {
        NSLog(@"模块化 - %@ 协议未注册", protocolName);
        return nil;
    }
    
    /** 检测协议对应的实例对象是否已经存在 */
    id instance = [self.instanceServicesInfo objectForKey:protocolName];
    if (instance) {
        return instance;
    }
    
    /** 获取类对象 */
    Class serviceClass = [self classFromProtocol:serviceProtocol];
    
    /** 创建实例对象 */
    if ([[serviceClass class] respondsToSelector:@selector(isChcheInstance)]) {
        if ([[serviceClass class] isChcheInstance]) { // 单例
            if ([[serviceClass class] respondsToSelector:@selector(shareInstance)]) {
                instance = [[serviceClass class] shareInstance];
            } else {
                instance = [[serviceClass alloc] init];
            }
            
            // 只要isChcheInstance = YES 就存储实例对象
            [self.instanceServicesInfo setObject:instance forKey:protocolName];
            
            return instance;
        }
    }
    
    return [[serviceClass alloc] init];
}

- (void)removeInstanceWithProtocolName:(NSString *)protocolName {
    if (!protocolName) {
        return;
    }
    
    [self.instanceServicesInfo removeObjectForKey:protocolName];
}

/** 注销所有服务 */
- (void)unRegisterAllService {
    [self.servicesInfo removeAllObjects];
    [self.instanceServicesInfo removeAllObjects];
}


#pragma mark - 私有方法

/** 检测协议是否被注册 */
- (BOOL)checkValidServiceProtocol:(Protocol *)serviceProtocol {
    NSString *protocolName = NSStringFromProtocol(serviceProtocol);
    [self.lock lock];
    NSDictionary *tempDict = [self.servicesInfo copy];
    [self.lock unlock];
    NSString *className = [tempDict objectForKey:protocolName];
    if (className.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - getter

- (NSMutableDictionary *)servicesInfo {
    if (_servicesInfo == nil) {
        _servicesInfo = [[NSMutableDictionary alloc] init];
    }
    return _servicesInfo;
}

- (NSMutableDictionary *)instanceServicesInfo {
    if (_instanceServicesInfo == nil) {
        _instanceServicesInfo = [[NSMutableDictionary alloc] init];
    }
    return _instanceServicesInfo;
}

- (NSRecursiveLock *)lock {
    if (_lock == nil) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

@end
