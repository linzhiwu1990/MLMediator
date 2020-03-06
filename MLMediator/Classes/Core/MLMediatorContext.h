//
//  MLMediatorContext.h
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
    MLMediatorContext必须是6种直播间共同用到的属性才写在这里。
 */
@interface MLMediatorContext : NSObject

/** 房间ID */
@property (nonatomic, copy) NSString *roomID;

/** 本场直播的ID */
@property (nonatomic, copy) NSString *showID;

/** 房间来源 */
@property (nonatomic, copy) NSString *roomSource;

/** 房间配置：通过full接口获取保留 */
@property (nonatomic, strong) NSDictionary *roomProfile;

/** 房间类型 */
@property (nonatomic, assign) NSUInteger roomType;

/** 房间模式 */
@property (nonatomic, assign) NSUInteger roomMode;

@property (nonatomic, assign) NSUInteger roomStatus;

@property (nonatomic, assign) NSInteger roomRole;

@property (nonatomic, assign, getter=isAnchor) BOOL anchor;

@end

NS_ASSUME_NONNULL_END
