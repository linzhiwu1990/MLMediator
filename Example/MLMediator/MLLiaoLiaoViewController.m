//
//  MLLiaoLiaoViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/4.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiaoLiaoViewController.h"
#import <MLMediator/MLMediator.h>
#import "MLMessageListView.h"

@interface MLLiaoLiaoViewController ()

@property (nonatomic, strong) MLMessageListView *messageListView;

@end

@implementation MLLiaoLiaoViewController

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.messageListView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat messageListViewX = 10;
    CGFloat messageListViewY = 0;
    CGFloat messageListViewW = self.view.frame.size.width - messageListViewX;
    CGFloat messageListViewH = self.view.frame.size.height;
    self.messageListView.frame = CGRectMake(messageListViewX, messageListViewY, messageListViewW, messageListViewH);
}

- (void)addMessage:(NSString *)message {
    
    MLDebugLog(@"发送礼物聊聊");
    [self.messageListView addMessage:message];
}


#pragma mark - getter

- (MLMessageListView *)messageListView {
    if (_messageListView == nil) {
        _messageListView = [[MLMessageListView alloc] init];
    }
    return _messageListView;
}

@end
