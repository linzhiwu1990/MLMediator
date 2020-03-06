//
//  MLEvent.h
//  Pods
//
//  Created by 林志武 on 2020/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLModuleProtocol;


@interface MLEvent : NSObject

/** 事件唯一标识 */
@property (nonatomic, assign) NSInteger ID;

/** 事件执行者 : 不能强引用，不然target不会释放*/
@property (nonatomic, weak) id target;

/** 执行方法 */
@property (nonatomic, assign) SEL selector;

/** 执行参数 */
//@property (nonatomic, strong) NSDictionary *params;

- (instancetype)initWithEvent:(NSInteger)eventID target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
