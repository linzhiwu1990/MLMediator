//
//  MLLiveDecorateScrollViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLLiveDecorateScrollViewController.h"
#import "MLLiveDecorateViewController.h"
#import "MLActivityViewController.h"
#import <MLMediator/MLMediator.h>

@interface MLLiveDecorateScrollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *clearScreenVC;
@property (nonatomic, strong) MLLiveDecorateViewController *decorateVC;
@property (nonatomic, strong) MLActivityViewController *activityVC;

@end

@implementation MLLiveDecorateScrollViewController

#pragma mark - 生命周期

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.hidden = YES;
    [self addChildViewController:self.clearScreenVC];
    [self addChildViewController:self.decorateVC];
    [self addChildViewController:self.activityVC];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.clearScreenVC.view];
    [self.scrollView addSubview:self.decorateVC.view];
    [self.scrollView addSubview:self.activityVC.view];
    [self.clearScreenVC didMoveToParentViewController:self];
    [self.decorateVC didMoveToParentViewController:self];
    [self.activityVC didMoveToParentViewController:self];
    
    self.scrollView.frame = self.view.bounds;
    self.clearScreenVC.view.frame = self.scrollView.bounds;
    
    CGFloat decorateX = CGRectGetMaxX(self.clearScreenVC.view.frame);
    CGFloat decorateY = 0;
    CGFloat decorateW = self.scrollView.frame.size.width;
    CGFloat decorateH = self.scrollView.frame.size.height;
    self.decorateVC.view.frame = CGRectMake(decorateX, decorateY, decorateW, decorateH);
    self.activityVC.view.frame = CGRectMake(CGRectGetMaxX(self.decorateVC.view.frame), decorateY, decorateW, decorateH);
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO]; // 布局之后再调用
}

#pragma mark - 协议实现
- (void)showDecorateLayerUI {
    self.view.hidden = NO;
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIViewController *)clearScreenVC {
    if (_clearScreenVC == nil) {
        _clearScreenVC = [[UIViewController alloc] init];
        _clearScreenVC.view.backgroundColor = [UIColor clearColor];
    }
    return _clearScreenVC;
}

- (MLLiveDecorateViewController *)decorateVC {
    if (_decorateVC == nil) {
        _decorateVC = [[MLLiveDecorateViewController alloc] init];
    }
    return _decorateVC;
}

- (MLActivityViewController *)activityVC {
    if (_activityVC == nil) {
        _activityVC = [[MLActivityViewController alloc] init];
    }
    return _activityVC;
}

@end
