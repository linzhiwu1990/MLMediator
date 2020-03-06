//
//  MLEvent.m
//  Pods
//
//  Created by 林志武 on 2020/2/16.
//

#import "MLEvent.h"

@implementation MLEvent

- (instancetype)initWithEvent:(NSInteger)eventID target:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        self.ID = eventID;
        self.target = target;
        self.selector = selector;
    }
    return self;
}

@end
