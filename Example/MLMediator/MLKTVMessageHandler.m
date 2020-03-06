//
//  MLKTVMessageHandler.m
//  MLMediator_Example
//
//  Created by 林志武 on 2020/3/6.
//  Copyright © 2020 linzhiwu. All rights reserved.
//

#import "MLKTVMessageHandler.h"
#import <MLMediator/MLMediator.h>

@interface MLKTVMessageHandler () <MLMessageProtocol>

@end

@implementation MLKTVMessageHandler


+ (void)didReceiveMessageWithMessageID:(NSString *)meesageID params:(NSDictionary *)params {
   
    NSLog(@"收到消息 - %@", meesageID);
}

@end
