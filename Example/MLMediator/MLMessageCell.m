//
//  MLMessageCell.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLMessageCell.h"

@interface MLMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation MLMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(NSString *)message {
    _message = message;
    
    self.messageLabel.text = message;
//    [self.messageLabel sizeToFit];
    
    
}

@end
