//
//  MLGiftPanelContainerView.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/3.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MLGift;
@protocol MLGiftPanelContainerViewDelegate;

@interface MLGiftPanelContainerView : UIView

@property (nonatomic, weak) id<MLGiftPanelContainerViewDelegate> delegate;

@end


@protocol MLGiftPanelContainerViewDelegate <NSObject>

- (void)giftPanelContainerView:(MLGiftPanelContainerView *)containerView  didSelectItemWithGift:(MLGift *)gift;

@end

NS_ASSUME_NONNULL_END
