//
//  MLDecorateTopViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLDecorateTopViewController.h"
#import <MLMediator/MLMediator.h>
#import "MLRoomInfoView.h"

@interface MLDecorateTopViewController ()

@property (nonatomic) MLRoomInfoView *roomInfoView;

@end

@implementation MLDecorateTopViewController

- (void)dealloc {
    MLDebugLog();
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.roomInfoView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.roomInfoView.frame = self.view.bounds;
}

- (MLRoomInfoView *)roomInfoView {
    if (_roomInfoView == nil) {
        _roomInfoView = [[NSBundle mainBundle] loadNibNamed:@"MLRoomInfoView" owner:nil options:nil].lastObject;
    }
    return _roomInfoView;
}

@end
