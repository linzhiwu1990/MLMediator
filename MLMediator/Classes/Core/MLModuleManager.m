//
//  MLModuleManager.m
//  MomoChat
//
//  Created by 林志武 on 2019/6/19.
//

#import "MLModuleManager.h"
#import "MLMediatorMacro.h"


static NSString * const kModuleClassNameKey = @"moduleClassName";
static NSString * const kModuleLevelKey = @"moduleLevel";
static NSString * const kModulePriorityKey = @"modulePriority";
static NSString * const kHasInstantiatedKey = @"hasInstantiatedKey";


@interface MLModuleManager () 

/** 模块数组：用于存放已经注册的所有模块的实例对象 */
@property (nonatomic, strong) NSMutableArray<id<MLModuleProtocol>> *modules;

/** 模块信息数组：存放模块信息，比如模块名称，模块层级，模块优先级 */
@property (nonatomic, strong) NSMutableArray<NSDictionary*> *moduleInofs;

@end

@implementation MLModuleManager

#pragma mark - 生命周期

+ (instancetype)sharedInstance {
    static MLModuleManager *_sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MLModuleManager alloc] init];
    });
    return _sharedInstance;
}

- (void)dealloc {
    MLDebugLog();
}

#pragma mark - 公共方法

/** 注册单个模块 */
- (void)registerModule:(Class)moduleClass {
    MLDebugLog(@"注册模块 = %@", NSStringFromClass(moduleClass));
    if (!moduleClass) {
        return;
    }
    
    /** 过滤moduleClass 不符合 MLModuleProtocol 情况*/
    if (![moduleClass conformsToProtocol:@protocol(MLModuleProtocol)]) {
        return;
    }
    
    /** 过滤模块是否已经被注册 */
    __block BOOL containFlag = NO;
    [self.modules enumerateObjectsUsingBlock:^(id<MLModuleProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:moduleClass]) {
            containFlag = YES;
            *stop = YES;
        }
    }];
    if (containFlag) {
        return;
    }

    /** 过滤类名异常 */
    NSString *moduleName = NSStringFromClass(moduleClass);
    if (!moduleName) {
        return;
    }
    
    /** 构建模块信息moduleInfo字典,并且添加到moduleInofs中 */
    NSMutableDictionary *moduleInfo = [NSMutableDictionary dictionary];
    [moduleInfo setObject:moduleName forKey:kModuleClassNameKey];
    [self.moduleInofs addObject:moduleInfo];

    /** 根据类创建对应的模块对象 并且添加到modules中*/
    id<MLModuleProtocol> moduleInstance = [[moduleClass alloc] init];
    [self.modules addObject:moduleInstance];
    
    [moduleInfo setObject:@(YES) forKey:kHasInstantiatedKey];
    
    NSInteger moduleLevel = 1;
    if ([moduleInstance respondsToSelector:@selector(moduleLevel)]) {
        moduleLevel = [moduleInstance moduleLevel];
    }
    [moduleInfo setObject:@(moduleLevel) forKey:kModuleLevelKey];
    
    
    MLDebugLog(@"注册成功 = %@", NSStringFromClass(moduleClass));

    /** 模块实例对象排序  */
    [self.modules sortUsingComparator:^NSComparisonResult(id<MLModuleProtocol> obj1, id<MLModuleProtocol> obj2) {
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
    
}

/** 注销单个模块 */
- (void)unRegisterModule:(Class)moduleClass {
    MLDebugLog(@"注销模块 = %@", NSStringFromClass(moduleClass));
    if (!moduleClass) {
        return;
    }
    
    NSString *moduleName = NSStringFromClass(moduleClass);
    
    // 注销对应的moduleInfo
    //    [self.moduleInofs filterUsingPredicate:[NSPredicate predicateWithFormat:@"%@==%@", kModuleClassNameKey, moduleName]];
    for (NSDictionary *moduleInfos in self.moduleInofs.reverseObjectEnumerator) {
        if ([[moduleInfos objectForKey:kModuleClassNameKey] isEqualToString:moduleName]) {
            NSLog(@"注销模块 moduleInfos = %@", moduleName);
            [self.moduleInofs removeObject:moduleInfos];
        }
    }
    
    __block NSInteger index = -1;
    [self.modules enumerateObjectsUsingBlock:^(id<MLModuleProtocol> obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:moduleClass]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index >= 0) {
        id<MLModuleProtocol> unRegisterModule = [self.modules objectAtIndex:index];
        [unRegisterModule moduleWillUnRegister];
        
        [self.modules removeObjectAtIndex:index];
        MLDebugLog(@"注销模块成功 = %@", NSStringFromClass(moduleClass));
    }
}

/** plist文件批量注册模块 */
- (void)registerModulesWithPlistFileName:(NSString *)fileName {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    // 过滤路径不存在情况
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return;
    }

    /** 获取模块列表 */
    NSArray<NSDictionary *> *moduleList = [[NSArray alloc] initWithContentsOfFile:filePath];

    /** 添加模块信息到数 moduleInofs：过滤已经存在的模块信息 */
    NSMutableDictionary<NSString *, NSNumber *> *tempDictionary = [NSMutableDictionary dictionary]; // 用于记录已经存在的模块信息。
    [self.moduleInofs enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *moduleClassName = [obj objectForKey:kModuleClassNameKey];
        [tempDictionary setObject:@(1) forKey:moduleClassName];
    }];
    [moduleList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { //
        if (!tempDictionary[[obj objectForKey:kModuleClassNameKey]]) {
            [self.moduleInofs addObject:obj];
        }
    }];
    
    /** 批量排序注册模块 */
    [self.moduleInofs sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSNumber *module1Level = (NSNumber *)[obj1 objectForKey:kModuleLevelKey];
        NSNumber *module2Level =  (NSNumber *)[obj2 objectForKey:kModuleLevelKey];
        if (module1Level.integerValue != module2Level.integerValue) {
            return module1Level.integerValue > module2Level.integerValue;
        } else {
            NSNumber *module1Priority = (NSNumber *)[obj1 objectForKey:kModulePriorityKey];
            NSNumber *module2Priority = (NSNumber *)[obj2 objectForKey:kModulePriorityKey];
            return module1Priority.integerValue < module2Priority.integerValue;
        }
    }];
    
    /** 批量注册模块 */
    NSMutableArray *tempArray = [NSMutableArray array];
    [self.moduleInofs enumerateObjectsUsingBlock:^(NSDictionary *moduleDic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *moduleName = [moduleDic objectForKey:kModuleClassNameKey];
        Class moduleClass = NSClassFromString(moduleName);
        
        BOOL hasInstantiated = ((NSNumber *)[moduleDic objectForKey:kHasInstantiatedKey]).boolValue;
        if (NSStringFromClass(moduleClass) && !hasInstantiated) {
            MLDebugLog(@"批量注册模块 = %@", NSStringFromClass(moduleClass));
            id<MLModuleProtocol> moduleInstance = [[moduleClass alloc] init];
            [tempArray addObject:moduleInstance];
            MLDebugLog(@"批量注册模块成功 = %@", NSStringFromClass(moduleClass));
        }
    }];
    
    [self.modules addObjectsFromArray:tempArray];
}

/** 注销所有模块 */
- (void)unRegisterAllModules {
#warning 遍历数组时需要删除数组个数，使用逆向遍历，待验证。
    // 遍历数组时需要删除数组个数，使用逆向遍历，待验证。
    for (id<MLModuleProtocol>module in self.modules.reverseObjectEnumerator) {
        id<MLModuleProtocol> moduleInstance = module;
        [self unRegisterModule:[moduleInstance class]];
    }
    
//    [self.moduleInofs removeAllObjects];
}


#pragma mark - 协议

#pragma mark 模块生命周期

- (void)moduleSetup {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:@selector(moduleSetup)]) {
            [module moduleSetup];
        }
    }
}

- (void)moduleInit {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:@selector(moduleInit)]) {
            [module moduleInit];
        }
    }
}

// 实现此方法，不做任何操作，防止外面不小心调用，导致崩溃，此方法不能提供给外面手动调用。必须在注销之前自动调用
- (void)moduleWillUnRegister {
    
}

#pragma mark view的生命周期
- (void)viewDidLoad {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewDidLoad];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewWillAppear:animated];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewDidAppear:animated];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewWillDisappear:animated];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewDidDisappear:animated];
        }
    }
}

- (void)viewDidLayoutSubviews {
    for (id<MLModuleProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module viewDidLayoutSubviews];
        }
    }
}

//#pragma mark 房间业务
//- (void)roomDidUpdateConfig:(NSDictionary *)config {
//    for (id<MLModuleProtocol> module in self.modules) {
//        if ([module respondsToSelector:_cmd]) {
//            [module roomDidUpdateConfig:config];
//        }
//    }
//}
//
//- (void)roomDidReceiveIMMessage:(NSDictionary *)message {
//    for (id<MLModuleProtocol> module in self.modules) {
//        if ([module respondsToSelector:_cmd]) {
//            [module roomDidReceiveIMMessage:message];
//        }
//    }
//}

#pragma mark - 私有方法

#pragma mark - getter

- (NSMutableArray<id<MLModuleProtocol>> *)modules {
    if (_modules == nil) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (NSMutableArray<NSDictionary *> *)moduleInofs {
    if (_moduleInofs == nil) {
        _moduleInofs = [NSMutableArray array];
    }
    return _moduleInofs;
}

@end
