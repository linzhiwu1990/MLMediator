//
//  MLGift.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/3.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLGift : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSUInteger price;

@end

NS_ASSUME_NONNULL_END
