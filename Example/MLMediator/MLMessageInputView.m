//
//  MLMessageInputView.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLMessageInputView.h"

@interface MLMessageInputView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *danmakuButton;

@end

@implementation MLMessageInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textField.delegate = self;
//    [self.textField setValue:[UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1.0] forKey:@"_placeholderLabel.textColor"];
}

- (IBAction)clickSendButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageInputView:didClickedSendButtonWithText:)]) {
        [self.delegate messageInputView:self didClickedSendButtonWithText:self.textField.text];
        self.textField.text = nil;
    }
}

- (IBAction)clickDamakuButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        self.textField.placeholder = @"1陌币发送弹幕消息";
    } else {
        self.textField.placeholder = @"说点什么吧";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self clickSendButton:self.sendButton];
    
    return YES;
}


@end
