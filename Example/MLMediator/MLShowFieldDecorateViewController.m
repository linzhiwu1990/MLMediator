//
//  MLShowFieldDecorateViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLShowFieldDecorateViewController.h"
#import "MLPublicDecorateViewController.h"
#import <MLMediator/MLMediator.h>


@interface MLShowFieldDecorateViewController ()

@property (nonatomic, strong) MLPublicDecorateViewController *publicDecorateVC;

@property (nonatomic, strong) UIButton *activityImageView;

@end

@implementation MLShowFieldDecorateViewController


static inline UIEdgeInsets mintSafeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.publicDecorateVC];
    [self.view addSubview:self.publicDecorateVC.view];
    [self.publicDecorateVC didMoveToParentViewController:self];
    
    [self.view addSubview:self.activityImageView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.publicDecorateVC.view.frame = self.view.bounds;
    
    UIEdgeInsets insets = mintSafeAreaInset(self.view);

    CGFloat activityImageViewX = 10;
    CGFloat activityImageViewY =  insets.top + 100;
    CGFloat activityImageViewW = 80;
    CGFloat activityImageViewH = 80;
    self.activityImageView.frame = CGRectMake(activityImageViewX, activityImageViewY, activityImageViewW, activityImageViewH);
}



#pragma mark - getter

- (MLPublicDecorateViewController *)publicDecorateVC {
    if (_publicDecorateVC == nil) {
        _publicDecorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
    }
    return _publicDecorateVC;
}

- (UIButton *)activityImageView {
    if (_activityImageView == nil) {
        _activityImageView = [UIButton buttonWithType:UIButtonTypeCustom];\
        [_activityImageView setImage:[UIImage imageNamed:@"enter_icon"] forState:UIControlStateNormal];
        _activityImageView.adjustsImageWhenHighlighted = NO;
    }
    return _activityImageView;
}

@end
