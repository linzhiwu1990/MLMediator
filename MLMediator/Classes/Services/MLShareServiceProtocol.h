//
//  MLShareServiceProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/4.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MLServiceProtocol;

@protocol MLShareServiceProtocol <MLServiceProtocol>

- (void)showSharePane;

@end

NS_ASSUME_NONNULL_END
