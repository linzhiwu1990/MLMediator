//
//  MLMediatorMacro.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/6/24.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#ifndef MLMediatorMacro_h
#define MLMediatorMacro_h

#ifdef DEBUG

# define MLDebugLog(fmt, ...) NSLog((@"<模块化>""%s: "fmt), __FUNCTION__, ##__VA_ARGS__);

#else

# define MLDebugLog(...);

#endif

#endif /* MLMediatorMacro_h */
