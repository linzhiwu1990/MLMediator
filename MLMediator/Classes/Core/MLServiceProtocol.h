//
//  MLServiceProtocol.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLServiceProtocol <NSObject>

@optional

/** 标记是否缓存对象：YES:会缓存实例对象，多次调用instanceFromProtocol返回都是同一个对象 NO：不缓存实例对象, */
+ (BOOL)isChcheInstance;

/** isChcheInstance = YES,时，才会检测是否实现shareInstance*/
+ (id)shareInstance;

@end

NS_ASSUME_NONNULL_END
