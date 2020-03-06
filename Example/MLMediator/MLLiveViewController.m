//
//  MLLiveViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/8.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiveViewController.h"
#import <MLMediator/MLMediator.h>
#import "MLBasicsModule.h"
#import "MLLiveMediaModule.h"
#import "MLLiveDecorateModule.h"

@interface MLLiveViewController () <MLModuleDelegateProtocol>

@property (nonatomic, strong) MLMediator *mediator;

@end

@implementation MLLiveViewController

#pragma mark - 生命周期

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 手动注册模块 */
    [self.mediator registerModule:[MLBasicsModule class]];
    [self.mediator registerModule:[MLLiveMediaModule class]];
    [self.mediator registerModule:[MLLiveDecorateModule class]];
    
    self.mediator.content.anchor = YES;
    
    [self.mediator.moduleManager moduleSetup];
    [self.mediator.moduleManager moduleInit];
    [self.mediator.moduleManager viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.mediator.moduleManager viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mediator.moduleManager viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.mediator.moduleManager viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.mediator.moduleManager viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.mediator.moduleManager viewDidDisappear:animated];
}

#pragma mark - getter

- (MLMediator *)mediator {
    if (_mediator == nil) {
        _mediator = [MLMediator sharedInstance];
        _mediator.sourceVC = self;
    }
    return _mediator;
}


@end
