//
//  MLMessageManager.h
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
    消息管理员：用于中转IM消息
 */

@interface MLMessageManager : NSObject


- (void)registerMessageID:(NSString *)messageID forClass:(Class)className;

- (void)distributeMessageID:(NSString *)messageID;
- (void)distributeMessageID:(NSString *)messageID params:(nullable NSDictionary *)params;

- (void)unRegisterAllMessage;


@end

NS_ASSUME_NONNULL_END
