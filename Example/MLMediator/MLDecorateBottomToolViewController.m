//
//  MLDecorateBottomToolViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLDecorateBottomToolViewController.h"
#import <MLMediator/MLMediator.h>
#import <TWMessageBarManager/TWMessageBarManager.h>

@interface MLDecorateBottomToolViewController ()

//@property (nonatomic, strong) UIButton *closeButton;
//@property (nonatomic, strong) UIButton *giftButton;
//@property (nonatomic, strong) UIButton *shareButton;
//@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, strong) UIButton *messageButton;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MLDecorateBottomToolViewController

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(decorateBottomToolVCDidClickedMessageButton:)]) {
        [self.delegate decorateBottomToolVCDidClickedMessageButton:self];
    }
}

- (void)clickActionButton:(UIButton *)actionButton {
    if (actionButton.tag == 0) { // 关闭
        [[MLMediator sharedInstance] destroyAll];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (actionButton.tag == 1) { // 菜单
        [self showMoreAlertController];
        
    } else if (actionButton.tag == 2) { // 分享
        id<MLShareServiceProtocol> shareService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLShareServiceProtocol)];
        [shareService showSharePane];
        
    } else if (actionButton.tag == 3) { // 礼物
        id<MLGiftServiceProtocol> giftService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLGiftServiceProtocol)];
        [giftService showGiftPanel];
    }
}

#pragma mark - 私有方法

- (void)showMoreAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"待开发功能" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"最小化" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"最小化" description:@"开发中" type:TWMessageBarMessageTypeInfo];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"清晰度" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"清晰度" description:@"开发中" type:TWMessageBarMessageTypeInfo];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"连线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"连线" description:@"开发中" type:TWMessageBarMessageTypeInfo];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"KTV" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"转盘" description:@"开发中" type:TWMessageBarMessageTypeInfo];
        
        id<MLKTVModuleServiceProtocol> service = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLKTVModuleServiceProtocol)];
        [service showPanel];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [self presentViewController:alertController animated:true completion:NULL];
}

#pragma mark - getter

- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"ml_mp_btn_quit", @"ml_mp_btn_more", @"ml_icon_private_share", @"ml_mp_btn_gift"];
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
