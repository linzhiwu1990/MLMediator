//
//  MLServiceManager.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
    服务管理员：用于管理服务生命周期、创建服务、注册服务
 */
@interface MLServiceManager : NSObject

/** plist文件批量注册服务 */
- (void)registerServiceWithPlistFileName:(NSString *)fileName;

/** 通过类协议 注册 服务 */
- (void)registerClass:(Class)serviceClass forProtocol:(Protocol *)serviceProtocol;

/** 通过协议获取对应的类 */
- (Class)classFromProtocol:(Protocol *)serviceProtocol;

/** 通过协议获取对应的实例对象 */
- (id)instanceFromProtocol:(Protocol *)serviceProtocol;

/** 移除对应协议的实力对象*/
- (void)removeInstanceWithProtocolName:(NSString *)protocolName;

/** 注销所有服务 */
- (void)unRegisterAllService;

@end

NS_ASSUME_NONNULL_END
