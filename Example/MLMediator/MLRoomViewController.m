//
//  MLRoomViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/21.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLRoomViewController.h"
#import <MLMediator/MLMediator.h>
#import "MLBasicsModule.h"
#import "MLMediaModule.h"
#import "MLDecorateModule.h"
#import "MLKTVModule.h"

@interface MLRoomViewController () <MLModuleDelegateProtocol>

@property (nonatomic, strong) MLMediator *mediator;

@end

@implementation MLRoomViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    // plist文件批量注册模块
    [self.mediator registerModulesWithPlistFileName:@"MLMediator.bundle/ModuleList"];
    [self.mediator registerModule:[MLKTVModule class]];
    
    // plist文件批量注册服务
    [self.mediator registerServiceWithPlistFileName:@"MLMediator.bundle/ServicesList"];
        
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

#pragma mark - 事件处理

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.mediator unRegisterAllModules];
//}

#pragma mark - 私有方法


#pragma mark - getter

- (MLMediator *)mediator {
    if (_mediator == nil) {
        _mediator = [MLMediator sharedInstance];
        _mediator.sourceVC = self;
    }
    return _mediator;
}



@end
