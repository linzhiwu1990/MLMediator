//
//  MLDecorateBottomToolViewController.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLDecorateBottomToolViewControllerDelegate;

@interface MLDecorateBottomToolViewController : UIViewController

@property (nonatomic, weak) id<MLDecorateBottomToolViewControllerDelegate> delegate;

@end

@protocol MLDecorateBottomToolViewControllerDelegate <NSObject>

- (void)decorateBottomToolVCDidClickedMessageButton:(MLDecorateBottomToolViewController *)bottomVC;

@end

NS_ASSUME_NONNULL_END
