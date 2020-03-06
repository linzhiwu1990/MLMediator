//
//  MLDecorateServiceProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/3.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLGift;
@protocol MLServiceProtocol;

@protocol MLDecorateVCServiceProtocol <MLServiceProtocol>

- (void)hideBottomBar;
- (void)showBottomBar;

/** 聊聊显示送礼物消息 */
- (void)showGiftMessage:(MLGift *)gift;

@end

NS_ASSUME_NONNULL_END
