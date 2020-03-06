//
//  MLMessageManager.m
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/3/5.
//

#import "MLMessageManager.h"
#import "MLMessageProtocol.h"

@interface MLMessageManager ()

@property (nonatomic, strong) NSMapTable *routes;


@end

@implementation MLMessageManager

#pragma mark - 公共方法


- (void)registerMessageID:(NSString *)messageID forClass:(Class)className {
    NSParameterAssert(messageID != nil);
    NSParameterAssert(className != nil);
      
    /** 过滤已注册的action */
    Class classInstance = (Class)[self.routes objectForKey:messageID];
    if (classInstance) {
      return;
    }

    [self.routes setObject:className forKey:messageID];
}


- (void)distributeMessageID:(NSString *)messageID {
    [self distributeMessageID:messageID params:nil];
}

- (void)distributeMessageID:(NSString *)messageID params:(nullable NSDictionary *)params {
    NSParameterAssert(messageID != nil);

    Class<MLMessageProtocol> classInstance = (Class)[self.routes objectForKey:messageID];
    if (classInstance) {
        if ([classInstance respondsToSelector:@selector(didReceiveMessageWithMessageID:params:)]) {
            [classInstance didReceiveMessageWithMessageID:messageID params:params];
        }
    }
}

- (void)unRegisterAllMessage {
    [self.routes removeAllObjects];
    self.routes = nil;
}

#pragma mark - getter


- (NSMapTable *)routes {
    if (_routes == nil) {
        _routes = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return _routes;
}


@end
