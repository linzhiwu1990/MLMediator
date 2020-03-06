//
//  MLBasicsModule.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/24.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 MLBasicsModule: 存放直播间基础业务，交友、FM房间共同拥有的东西，
    比如：礼物模块、IM模块，比如进房间都要请求roomProfile。等公共业务，可以无需修改的接入各种类型的房间。
 */


@interface MLBasicsModule : NSObject

@end

NS_ASSUME_NONNULL_END
