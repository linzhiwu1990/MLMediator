//
//  MLMediaModuleServiceProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/25.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MLServiceProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol MLMediaModuleServiceProtocol <MLServiceProtocol>


- (void)startPlay;

@end

NS_ASSUME_NONNULL_END
