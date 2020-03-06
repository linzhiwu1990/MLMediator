//
//  MLMessageInputView.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLMessageInputViewDelegate;

@interface MLMessageInputView : UIView

@property (nonatomic, weak) id<MLMessageInputViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@protocol MLMessageInputViewDelegate <NSObject>

- (void)messageInputView:(MLMessageInputView *)messageInputView didClickedSendButtonWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
