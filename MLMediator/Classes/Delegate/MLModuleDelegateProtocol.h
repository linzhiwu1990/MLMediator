//
//  MLModuleDelegateProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/24.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 模块代理协议：用于兼容旧版本，用于使用MLMediator模块和没使用MLMediatord模块之间的通讯，这个代理默认是房间控制器 */
@protocol MLModuleDelegateProtocol <NSObject>

@end

NS_ASSUME_NONNULL_END
