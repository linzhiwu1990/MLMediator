//
//  MLDecorateViewController.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/28.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLMediator/MLMediator.h>


NS_ASSUME_NONNULL_BEGIN


/*
    装饰层直播端和观众端公共业务
 */
@interface MLPublicDecorateViewController : UIViewController <MLDecorateVCServiceProtocol>

@end

NS_ASSUME_NONNULL_END
