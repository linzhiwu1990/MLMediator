//
//  MLGiftServiceProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLServiceProtocol;

@protocol MLGiftServiceProtocol <MLServiceProtocol>

/** 显示礼物面板 */
- (void)showGiftPanel;

- (void)sendGift:(NSDictionary *)gift;

@end

NS_ASSUME_NONNULL_END
