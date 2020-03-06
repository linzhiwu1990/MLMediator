//
//  MLMediaModuleService.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/25.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLMediaModuleService.h"
#import <MLMediator/MLMediator.h>


@interface MLMediaModuleService () <MLMediaModuleServiceProtocol>

@end

@implementation MLMediaModuleService

#pragma mark - 生命周期


#pragma mark - 协议实现

- (void)startPlay {
    MLDebugLog(@"开始播放");
}

@end
