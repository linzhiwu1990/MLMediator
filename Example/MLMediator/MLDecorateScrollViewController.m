//
//  MLDecorateScrollViewController.m
//  MomoChat
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import "MLDecorateScrollViewController.h"
#import "MLShowFieldDecorateViewController.h"
#import <MLMediator/MLMediator.h>


@interface MLDecorateScrollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MLShowFieldDecorateViewController *decorateVC;

@property (nonatomic, strong) UIViewController *clearScreenVC;

@end

@implementation MLDecorateScrollViewController

#pragma mark - 生命周期

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.clearScreenVC];
    [self addChildViewController:self.decorateVC];

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.clearScreenVC.view];
    [self.scrollView addSubview:self.decorateVC.view];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 0);
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    self.clearScreenVC.view.frame = self.scrollView.bounds;
    self.decorateVC.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - delegate


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


- (MLShowFieldDecorateViewController *)decorateVC {
    if (_decorateVC == nil) {
        _decorateVC = [[MLShowFieldDecorateViewController alloc] init];
    }
    return _decorateVC;
}

- (UIViewController *)clearScreenVC {
    if (_clearScreenVC == nil) {
        _clearScreenVC = [[UIViewController alloc] init];
        _clearScreenVC.view.backgroundColor = [UIColor clearColor];
    }
    return _clearScreenVC;
}

@end
