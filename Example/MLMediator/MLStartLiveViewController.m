//
//  MLStartLiveViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLStartLiveViewController.h"
#import <TXLivePush.h>
#import "MLLiveViewController.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import <MLMediator/MLMediator.h>


@interface MLStartLiveViewController () <TXLivePushListener>

@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) TXLivePush *livePush;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@end

@implementation MLStartLiveViewController

#pragma mark - 生命周期

- (void)dealloc {
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self.view insertSubview:self.previewView atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
    [self.livePush startPreview:self.previewView];
//    [self.livePush setBeautyStyle:BEAUTY_STYLE_NATURE beautyLevel:5 whitenessLevel:7 ruddinessLevel:5];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.previewView.frame = self.view.bounds;
}

#pragma mark - 事件处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)clickCloseButton:(id)sender {
    [self.livePush stopPreview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickStartLiveButton:(id)sender {
    [self.view endEditing:YES];
    if (self.titleTextField.text.length <= 0) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"开始直播" description:@"请输入直播标题" type:TWMessageBarMessageTypeError];
        return;
    }
    
    [self.livePush stopPreview];    
    MLLiveViewController *liveVC = [[MLLiveViewController alloc] init];
    [self.navigationController pushViewController:liveVC animated:NO];
    
}

#pragma mark - TXLivePushListener

- (void)onPushEvent:(int)EvtID withParam:(NSDictionary *)param {
//    MLDebugLog(@"pushEvent = %d", EvtID);
}

#pragma mark - getter

- (UIView *)previewView {
    if (_previewView == nil) {
        _previewView = [[UIView alloc] init];
        _previewView.userInteractionEnabled = NO;
    }
    return _previewView;
}

- (TXLivePush *)livePush {
    if (_livePush == nil) {
        TXLivePushConfig *config = [[TXLivePushConfig alloc] init];
        _livePush = [[TXLivePush alloc] initWithConfig:config];
        _livePush.delegate = self;
    }
    return _livePush;
}

@end
