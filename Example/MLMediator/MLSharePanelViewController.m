//
//  MLSharePanelViewController.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/4.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLSharePanelViewController.h"
#import <MLMediator/MLMediator.h>
#import <TWMessageBarManager/TWMessageBarManager.h>

@interface MLSharePanelViewController () <MLShareServiceProtocol>

@end

@implementation MLSharePanelViewController

#pragma mark - 生命周期

//+ (BOOL)isChcheInstance {
//    return YES;
//}

- (void)dealloc {
    
    MLDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 事件处理

- (IBAction)clickCancelButton:(id)sender {
    [self dismiss];
}

- (IBAction)clickBgButton:(id)sender {
    [self dismiss];
}

- (IBAction)clickActionButton:(UIButton *)actionButton {
    if (actionButton.tag == 0) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"分享模块" description:@"分享到微信成功" type:TWMessageBarMessageTypeSuccess];
    } else if (actionButton.tag == 1) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"分享模块" description:@"分享到朋友圈成功" type:TWMessageBarMessageTypeSuccess];
    } else if (actionButton.tag == 2) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"分享模块" description:@"分享到QQ成功" type:TWMessageBarMessageTypeSuccess];
    } else if (actionButton.tag == 3) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"分享模块" description:@"分享到QQ空间成功" type:TWMessageBarMessageTypeSuccess];
    } else {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"分享模块" description:@"分享到微博成功" type:TWMessageBarMessageTypeSuccess];
    }
}

#pragma mark - 协议

- (void)showSharePane {
    UIViewController *sourceVC = [MLMediator sharedInstance].sourceVC;
    [sourceVC addChildViewController:self];
    [sourceVC.view addSubview:self.view];
    self.view.frame = sourceVC.view.bounds;
    [sourceVC didMoveToParentViewController:sourceVC];
}

#pragma mark - 私有方法

- (void)dismiss {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
