//
//  MLKTVModuleService.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/26.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLKTVModuleService.h"
#import <TWMessageBarManager/TWMessageBarManager.h>


@implementation MLKTVModuleService

- (void)showPanel {
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"KTV模块" description:@"显示KTV面板" type:TWMessageBarMessageTypeInfo];
}

@end
