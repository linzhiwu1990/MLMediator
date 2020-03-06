//
//  MLDecorateViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLPublicDecorateViewController.h"
#import "MLDecorateTopViewController.h"
#import "MLDecorateBottomToolViewController.h"
#import "MLLiaoLiaoViewController.h"
#import "MLGift.h"
#import "MLMessageInputView.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import "MLLiveBottomBarViewController.h"


@interface MLPublicDecorateViewController () <MLDecorateBottomToolViewControllerDelegate, MLMessageInputViewDelegate, MLLiveBottomBarViewControllerDelegate>

@property (nonatomic, strong) MLDecorateTopViewController *topVC;
@property (nonatomic, strong) MLLiaoLiaoViewController *liaoliaoVC;
@property (nonatomic, strong) MLMessageInputView *messageInputView;

@property (nonatomic, strong) MLDecorateBottomToolViewController *audienceBottomToolVC;
@property (nonatomic, strong) MLLiveBottomBarViewController *liveBottomToolVC;

@property (nonatomic, assign, getter=isAnchor, readonly) BOOL anchor;

@end

@implementation MLPublicDecorateViewController

static inline UIEdgeInsets mintSafeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

#pragma mark - 生命周期

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.topVC];
    [self addChildViewController:self.liaoliaoVC];
    [self.view addSubview:self.topVC.view];
    [self.view addSubview:self.liaoliaoVC.view];
    [self.topVC didMoveToParentViewController:self];
    [self.liaoliaoVC didMoveToParentViewController:self];

    if (self.isAnchor) {
        [self addChildViewController:self.liveBottomToolVC];
        [self.view addSubview:self.liveBottomToolVC.view];
        [self.liveBottomToolVC didMoveToParentViewController:self];
    } else {
        [self addChildViewController:self.audienceBottomToolVC];
        [self.view addSubview:self.audienceBottomToolVC.view];
        [self.audienceBottomToolVC didMoveToParentViewController:self];
    }
    
    [self.view addSubview:self.messageInputView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:self.messageInputView.inputView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets insets = mintSafeAreaInset(self.view);
    
    CGFloat messageInputViewX = 0;
    CGFloat messageInputViewH = 47;
    CGFloat messageInputViewY = self.view.frame.size.height - messageInputViewH;
    CGFloat messageInputViewW = self.view.frame.size.width;
    self.messageInputView.frame = CGRectMake(messageInputViewX, messageInputViewY, messageInputViewW, messageInputViewH);
    
    CGFloat bottomToolW = self.view.frame.size.width;
    CGFloat bottomToolH = 40;
    CGFloat bottomToolX = 0;
    CGFloat bottomToolY = self.view.frame.size.height - bottomToolH - insets.bottom;
    if (self.isAnchor) {
        self.liveBottomToolVC.view.frame = CGRectMake(bottomToolX, bottomToolY, bottomToolW, bottomToolH);
    } else {
        self.audienceBottomToolVC.view.frame = CGRectMake(bottomToolX, bottomToolY, bottomToolW, bottomToolH);
    }
    
    CGFloat liaoliaoX = 0;
    CGFloat liaoliaoW = self.view.frame.size.width * 0.68;
    CGFloat liaoliaoH = 200;
    CGFloat liaoliaoY = bottomToolY - liaoliaoH;
    self.liaoliaoVC.view.frame = CGRectMake(liaoliaoX, liaoliaoY, liaoliaoW, liaoliaoH);
    
    CGFloat topX = 0;
    CGFloat topY = insets.top;
    CGFloat topW = self.view.frame.size.width;
    CGFloat topH = 114;
    self.topVC.view.frame = CGRectMake(topX, topY, topW, topH);
}

#pragma mark - 事件处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.messageInputView.textField isFirstResponder]) {
        [self.view endEditing:YES];
        self.messageInputView.hidden = YES;
        [self showBottomBar];
    }
}


#pragma mark - 代理、通知

#pragma mark MLDecorateBottomToolViewControllerDelegate

- (void)decorateBottomToolVCDidClickedMessageButton:(MLDecorateBottomToolViewController *)bottomVC {
    [self.messageInputView.textField becomeFirstResponder];
}

#pragma mark MLLiveBottomBarViewControllerDelegate

- (void)liveBottomBarVCDidClickedMessageButton:(MLLiveBottomBarViewController *)bottomVC {
    [self.messageInputView.textField becomeFirstResponder];
}

#pragma mark MLMessageInputViewDelegate

- (void)messageInputView:(MLMessageInputView *)messageInputView didClickedSendButtonWithText:(NSString *)text {

    // 发送IM消息
    id<MLIMServiceProtocol> imService = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLIMServiceProtocol)];
    [imService sendData:text];
    
    // 发送到聊聊消息
    NSString *message = [NSString stringWithFormat:@"用户昵称：%@", text];
    [self.liaoliaoVC addMessage:message];
    
}

#pragma mark 通知

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        return;
    }
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    CGFloat time = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat translationY = [UIScreen mainScreen].bounds.size.height - keyboardY;
    
    if (translationY == 0) { // 隐藏键盘
        self.messageInputView.hidden = YES;
//        id<MLDecorateVCServiceProtocol> decorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
//        [decorateVC showBottomBar];
        [self showBottomBar];
        
    } else {
       
        self.messageInputView.hidden = NO;
        [self hideBottomBar];
    }
    
    [UIView animateWithDuration:time delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.view.superview.transform = CGAffineTransformMakeTranslation(0, -translationY);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 实现协议

- (void)showBottomBar {
    [UIView animateWithDuration:0.25 animations:^{
        if (self.isAnchor) {
            self.liveBottomToolVC.view.alpha = 1.0;
        } else {
            self.audienceBottomToolVC.view.alpha = 1.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideBottomBar {
    [UIView animateWithDuration:0.25 animations:^{
        if (self.isAnchor) {
            self.liveBottomToolVC.view.alpha = 0.0;
        } else {
            self.audienceBottomToolVC.view.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showGiftMessage:(MLGift *)gift {
    // 显示聊聊消息；
    NSString *message = [NSString stringWithFormat:@"送出了%@，价值%ld陌陌币", gift.name, gift.price];
    [self.liaoliaoVC addMessage:message];
}

#pragma mark - getter

- (MLDecorateTopViewController *)topVC {
    if (_topVC == nil) {
        _topVC = [[MLDecorateTopViewController alloc] init];
    }
    return _topVC;
}

- (MLDecorateBottomToolViewController *)audienceBottomToolVC {
    if (_audienceBottomToolVC == nil) {
        _audienceBottomToolVC = [[MLDecorateBottomToolViewController alloc] init];
        _audienceBottomToolVC.delegate = self;
    }
    return _audienceBottomToolVC;
}

- (MLLiveBottomBarViewController *)liveBottomToolVC {
    if (_liveBottomToolVC == nil) {
        _liveBottomToolVC = [[MLLiveBottomBarViewController alloc] init];
        _liveBottomToolVC.delegate = self;
    }
    return _liveBottomToolVC;
}

- (MLLiaoLiaoViewController *)liaoliaoVC {
    if (_liaoliaoVC == nil) {
        _liaoliaoVC = [[MLLiaoLiaoViewController alloc] init];
    }
    return _liaoliaoVC;
}

- (MLMessageInputView *)messageInputView {
    if (_messageInputView == nil) {
        _messageInputView = [[NSBundle mainBundle] loadNibNamed:@"MLMessageInputView" owner:nil options:nil].lastObject;
        _messageInputView.hidden = YES;
        _messageInputView.delegate = self;
    }
    return _messageInputView;
}

- (BOOL)isAnchor {
    return [MLMediator sharedInstance].content.isAnchor;
}

@end
