//
//  MLMessageProtocol.h
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLMessageProtocol <NSObject>

+ (void)didReceiveMessageWithMessageID:(NSString *)meesageID params:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
