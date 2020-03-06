//
//  MLGiftService.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLGiftService.h"
#import "MLGiftListViewController.h"

@interface MLGiftService () 

@property (nonatomic, strong) MLGiftListViewController *giftVC;

@end

@implementation MLGiftService

+ (BOOL)isChcheInstance {
    return YES;
}

- (void)dealloc {
    MLDebugLog();
}

- (void)showGiftPanel {
    
    [self.giftVC show];
}

- (void)sendGift:(NSDictionary *)gift {
    
}

#pragma mark - getter

- (MLGiftListViewController *)giftVC {
    if (_giftVC == nil) {
        _giftVC = [[MLGiftListViewController alloc] init];
    }
    return _giftVC;
}

@end
