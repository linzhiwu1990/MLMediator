//
//  MLModuleEvent.h
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/3/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
    所有事件类型必须保证唯一
    命名规则：
       (1) 通用事件： 1 ~ 100
       (2) 业务事件: 模块ID + 事件ID、如：100 + 001
 */


/** 通用事件： */
typedef NS_ENUM(NSInteger, MLCommonEvent) {
    MLDidSwitchingModeEvent = 1,  // 切换房间模式事件：当房间的模式发生改变时会发送
    MLDidUpdateConfigEvent = 2, // 配置事件：当房间的配置发生改变时会调用
    MLDidReceiveIMMessageEvent = 3, // 接收IM事件：后期删掉，换成IM独立注册
};


/** A业务事件 */
typedef NS_ENUM(NSInteger, MLABusinessEvent) {
    MLBusinessAEvent = 100001,  // 切换房间模式事件：当房间的模式发生改变时会发送
    MLBusinessBEvent = 100002, // 配置事件：当房间的配置发生改变时会调用
};

