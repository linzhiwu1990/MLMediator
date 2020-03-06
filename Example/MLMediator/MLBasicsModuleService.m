//
//  MLBasicsModuleService.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/25.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLBasicsModuleService.h"
#import <MLMediator/MLMediator.h>


@interface MLBasicsModuleService ()<MLBasicsModuleServiceProtocol>

@end

@implementation MLBasicsModuleService

#pragma mark - 生命周期

- (instancetype)init {
    if (self = [super init]) {
        MLDebugLog();
    }
    return self;
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 协议实现

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)showLog {
    MLDebugLog(@"调用方法成功");
}


@end
