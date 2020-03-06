//
//  MLEventManager.h
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/2/17.
//

#import <Foundation/Foundation.h>

@protocol MLModuleProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface MLEventManager : NSObject

/** 注册模块事件 */
- (void)registerEvent:(NSInteger)eventID module:(id<MLModuleProtocol>)module selector:(SEL)selector;

/** 触发模块事件：带参数 */
- (void)triggerEvent:(NSInteger)eventID params:(nullable NSDictionary *)params;

/** 触发模块事件 不带参数*/
- (void)triggerEvent:(NSInteger)eventID;

/** 注销单个模块的所有eventI*/
- (void)unRegisterAllEventForModule:(id<MLModuleProtocol>)module;

/** 注销所有模块所有eventI*/
- (void)unRegisterAllEvent;

@end

NS_ASSUME_NONNULL_END
