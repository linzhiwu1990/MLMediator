//
//  MLIMManager.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLIMManager.h"
#import <TWMessageBarManager/TWMessageBarManager.h>

@interface MLIMManager ()


@end

@implementation MLIMManager


- (void)dealloc {
    MLDebugLog();
}
#pragma mark - 协议实现

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)connect:(NSString *)url {
    MLDebugLog(@"连接IM URL = %@", url);
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟10秒后收到IM消息
        NSMutableDictionary *message = [NSMutableDictionary dictionary];
        message[@"text"] = @"hello";
        [weakSelf imDidReceiveMessage:message];
    });
}

- (void)disconnect {
    MLDebugLog(@"断开IM");
}

- (void)reconnect {
    MLDebugLog(@"重连IM");
}

- (void)sendData:(NSString *)data {
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"IM模块" description:[NSString stringWithFormat:@"发送IM消息 = %@", data] type:TWMessageBarMessageTypeInfo];
}

#pragma mark - 私有方法

- (void)imDidReceiveMessage:(NSDictionary *)message {
    
    [[MLMediator sharedInstance] triggerEvent:MLDidReceiveIMMessageEvent];
}

@end
