//
//  MLLiveDecorateViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiveDecorateViewController.h"
#import "MLPublicDecorateViewController.h"
#import <MLMediator/MLMediator.h>


@interface MLLiveDecorateViewController ()

@property (nonatomic, strong) MLPublicDecorateViewController *publicDecorateVC;
@property (nonatomic, strong) UIButton *pkEnterImageView;

@end

@implementation MLLiveDecorateViewController

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
    
    [self.view addSubview:self.pkEnterImageView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.publicDecorateVC.view.frame = self.view.bounds;
    
    UIEdgeInsets insets = mintSafeAreaInset(self.view);
    CGFloat pkEnterX = 20;
    CGFloat pkEnterY = insets.top + 120;
    CGFloat pkEnterW = 90;
    CGFloat pkEnterH = 24;
    self.pkEnterImageView.frame = CGRectMake(pkEnterX, pkEnterY, pkEnterW, pkEnterH);

}

#pragma mark - getter

- (MLPublicDecorateViewController *)publicDecorateVC {
    if (_publicDecorateVC == nil) {
        _publicDecorateVC = [[MLMediator sharedInstance] instanceFromProtocol:@protocol(MLDecorateVCServiceProtocol)];
    }
    return _publicDecorateVC;
}

- (UIButton *)pkEnterImageView {
    if (_pkEnterImageView == nil) {
        _pkEnterImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pkEnterImageView setImage:[UIImage imageNamed:@"icon_pk_arena"] forState:UIControlStateNormal];
        
    }
    return _pkEnterImageView;
}

@end
