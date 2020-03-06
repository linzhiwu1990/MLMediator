//
//  MLLiveBottomBarViewController.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLLiveBottomBarViewControllerDelegate;

@interface MLLiveBottomBarViewController : UIViewController

@property (nonatomic, weak) id<MLLiveBottomBarViewControllerDelegate> delegate;

@end

@protocol MLLiveBottomBarViewControllerDelegate <NSObject>

- (void)liveBottomBarVCDidClickedMessageButton:(MLLiveBottomBarViewController *)bottomVC;


@end

NS_ASSUME_NONNULL_END
