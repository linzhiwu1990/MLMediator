//
//  MLEventManager.m
//  FBSnapshotTestCase
//
//  Created by 林志武 on 2020/2/17.
//

#import "MLEventManager.h"
#import "MLModuleProtocol.h"
#import "MLEvent.h"
#import "MLMediatorMacro.h"

@interface MLEventManager ()

/** 事件信息：用于存储eventID 与 执行对象的对应关系，key = eventID， value =  MLEvent对象  */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<MLEvent *> *> *eventDictionary;

@end

@implementation MLEventManager

#pragma mark - 生命周期

- (instancetype)init {
    if (self = [super init]) {
        MLDebugLog();
    }
    return self;
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 公共方法

/** 注册模块事件 */
- (void)registerEvent:(NSInteger)eventID module:(id<MLModuleProtocol>)module selector:(SEL)selector {
    
    // 过滤事件异常
    if (!selector || ![module conformsToProtocol:@protocol(MLModuleProtocol)] || ![module respondsToSelector:selector]) {
        MLDebugLog(@"事件 - 注册异常 EventID = %ld，module = %@， selector = %@", eventID, module, NSStringFromSelector(selector));
        return;
    }
    
    // 判断是否注册第一次注册eventID
    if (![self.eventDictionary objectForKey:@(eventID)]) {
        [self.eventDictionary setObject:@[].mutableCopy forKey:@(eventID)];
    }
   
    // 过滤已经注册情况
    NSMutableArray *eventArray = [self.eventDictionary objectForKey:@(eventID)];
    for (MLEvent *event in eventArray) {
        if (event.ID == eventID && [event.target isEqual:module]) {
            MLDebugLog(@"事件 - 重复注册 EventID = %ld，module = %@， selector = %@", eventID, module, NSStringFromSelector(selector));
            return;
        }
    }
    
    // 注册事件
    MLEvent *registerEvent = [[MLEvent alloc] initWithEvent:eventID target:module selector:selector];
    [eventArray addObject:registerEvent];
    
    // 事件排序: 按模块的优先级排序
   [eventArray sortUsingComparator:^NSComparisonResult(MLEvent *event1, MLEvent *event2) {
       id<MLModuleProtocol> obj1 = event1.target;
       id<MLModuleProtocol> obj2 = event2.target;
       NSNumber *module1Level = @(MLModuleLevelLow);
       NSNumber *module2Level = @(MLModuleLevelLow);
       if ([obj1 respondsToSelector:@selector(moduleLevel)]) {
           module1Level = @([obj1 moduleLevel]);
       }
       if ([obj2 respondsToSelector:@selector(moduleLevel)]) {
           module2Level = @([obj2 moduleLevel]);
       }
       if (module1Level.integerValue != module2Level.integerValue) {
           return module1Level.integerValue > module2Level.integerValue;
       } else {
           NSInteger module1Priority = 0;
           NSInteger module2Priority = 0;
           if ([obj1 respondsToSelector:@selector(modulePriority)]) {
               module1Priority = [obj1 modulePriority];
           }
           if ([obj2 respondsToSelector:@selector(modulePriority)]) {
               module2Priority = [obj2 modulePriority];
           }
           return module1Priority < module2Priority;
       }
   }];
   
    NSLog(@"eventInfo = %@", self.eventDictionary);
}

/** 触发模块事件：带参数 */
- (void)triggerEvent:(NSInteger)eventID params:(nullable NSDictionary *)params {
        
    // 过滤事件未注册
    NSMutableArray *eventArray = [self.eventDictionary objectForKey:@(eventID)];
    if (!eventArray || eventArray.count < 1) {
       MLDebugLog(@"事件 - 未注册 EventID = %ld", eventID);
       return;
    }
       
    // 分发事件
   [eventArray enumerateObjectsUsingBlock:^(MLEvent *event, NSUInteger idx, BOOL * _Nonnull stop) {
       if ([event.target respondsToSelector:event.selector]) {
           #pragma clang diagnostic push
           #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
           [event.target performSelector:event.selector withObject:params];
           #pragma clang diagnostic pop
       }
   }];
};

/** 触发模块事件 不带参数*/
- (void)triggerEvent:(NSInteger)eventID {    
    [self triggerEvent:eventID params:nil];
}

/** 注销单个模块的所有eventI*/
- (void)unRegisterAllEventForModule:(id<MLModuleProtocol>)module {
    if (!module || ![module conformsToProtocol:@protocol(MLModuleProtocol)]) {
        return;
    }
    
    [self.eventDictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSMutableArray<MLEvent *> * _Nonnull eventArray, BOOL * _Nonnull stop) {
        __block NSInteger index = -1;
        [eventArray enumerateObjectsUsingBlock:^(MLEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([event.target isEqual:module]) {
                index = idx;
                *stop = NO;
            }
        }];
        if (index >= 0) {
            [eventArray removeObjectAtIndex:index];
        }
        
    }];
    
    NSLog(@"eventInfo = %@", self.eventDictionary);
}

/** 注销所有模块所有eventI*/
- (void)unRegisterAllEvent {
    [self.eventDictionary removeAllObjects];
    self.eventDictionary = nil;
}


#pragma mark - getter

- (NSMutableDictionary<NSNumber *,NSMutableArray<MLEvent *> *> *)eventDictionary {
    if (_eventDictionary == nil) {
        _eventDictionary = [NSMutableDictionary dictionary];
    }
    return _eventDictionary;
}




@end
