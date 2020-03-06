//
//  MLGiftCell.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/3.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLGiftCell.h"
#import "MLGift.h"

@interface MLGiftCell ()

@property (weak, nonatomic) IBOutlet UILabel *giftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation MLGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGift:(MLGift *)gift {
    _gift = gift;
    
    self.giftNameLabel.text = gift.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld陌陌币", gift.price];
}

@end
