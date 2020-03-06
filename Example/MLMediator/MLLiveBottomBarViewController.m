//
//  MLLiveBottomBarViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiveBottomBarViewController.h"
#import <MLMediator/MLMediator.h>
#import <TWMessageBarManager/TWMessageBarManager.h>

@interface MLLiveBottomBarViewController ()

@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MLLiveBottomBarViewController

#pragma mark - 生命周期

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.messageButton];
    
    for (int i = 0; i < self.imageArray.count; i++) {
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionButton setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        actionButton.tag = i;
        [actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:actionButton];
        [self.buttonArray addObject:actionButton];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat messageButtonW = 36;
    CGFloat messageButtonH = 36;
    CGFloat messageButtonX = 10;
    CGFloat messageButtonY = (self.view.frame.size.height - messageButtonH) * 0.5;;
    self.messageButton.frame = CGRectMake(messageButtonX, messageButtonY, messageButtonW, messageButtonH);
    self.messageButton.layer.cornerRadius = messageButtonW * 0.5;
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        CGFloat actionButtonW = 36;
        CGFloat actionButtonH = 36;
        CGFloat actionButtonY = (self.view.frame.size.height - actionButtonH) * 0.5;
        CGFloat actionButtonX = (self.view.frame.size.width) - (1 + i) * (actionButtonW + 10) ;
        UIButton *actionButton = self.buttonArray[i];
        actionButton.frame = CGRectMake(actionButtonX, actionButtonY, actionButtonW, actionButtonH);
        actionButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
        actionButton.layer.cornerRadius = actionButtonW * 0.5;
        actionButton.layer.masksToBounds = YES;
    }
}

#pragma mark - 事件处理

- (void)clickMessageButton:(UIButton *)messageButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(liveBottomBarVCDidClickedMessageButton:)]) {
        [self.delegate liveBottomBarVCDidClickedMessageButton:self];
    }
}

- (void)clickActionButton:(UIButton *)actionButton {
    if (actionButton.tag == 0) { // 关闭
        [[MLMediator sharedInstance] destroyAll];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if (actionButton.tag == 1) { // 菜单
        [self showMoreAlertController];
        
    } else if (actionButton.tag == 2) { // 礼物
        id<MLGiftServiceProtocol> giftService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLGiftServiceProtocol)];
        [giftService showGiftPanel];
        
    } else if (actionButton.tag == 3) { // 录屏
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"录屏" description:@"开发中" type:TWMessageBarMessageTypeInfo];
        
    } else if (actionButton.tag == 4) { // k歌
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"K歌" description:@"播放背景音乐《等一分钟》" type:TWMessageBarMessageTypeInfo];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dengyifenzhong" ofType:@"mp3"];
        id<MLPushServiceProtocol> pushService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLPushServiceProtocol)];
        [pushService playBackgroundMusic:path];

    } else if (actionButton.tag == 5) { // PK
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"PK" description:@"显示PK竞技场入口" type:TWMessageBarMessageTypeInfo];
    }
}

#pragma mark - 私有方法

- (void)showMoreAlertController {
    
    id<MLPushServiceProtocol> pushService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLPushServiceProtocol)];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"切换美颜" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [pushService switchBeauty];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"静音开关" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [pushService swithMute];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"镜像开关" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [pushService swithMirror];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"切换摄像头" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [pushService switchCamera];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"切换屏幕方向" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [pushService switchScreenOrientation];
    }];
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    [self presentViewController:alertController animated:true completion:NULL];
}

#pragma mark - getter

- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"ml_mp_btn_quit", @"ml_mp_btn_more", @"ml_icon_chat_gift", @"ml_record_live", @"ml_bottom_music", @"ml_radio_pk_normal"];
    }
    return _imageArray;
}

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (UIButton *)messageButton {
    if (_messageButton == nil) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageButton setImage:[UIImage imageNamed:@"ml_broadcast_bottom_radio_chat"] forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(clickMessageButton:) forControlEvents:UIControlEventTouchUpInside];
        _messageButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
        _messageButton.layer.masksToBounds = YES;
    }
    return _messageButton;
}


@end
