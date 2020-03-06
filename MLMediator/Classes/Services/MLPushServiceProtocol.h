//
//  MLPushServiceProtocol.h
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/9.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLServiceProtocol;

/** 秀场推流器服务协议： */
@protocol MLPushServiceProtocol <MLServiceProtocol>

@required


- (void)startPreview;

- (void)stopPreview;

- (void)startPush:(NSString *)urlString;

- (void)stopPush;

- (void)destroy;

- (void)playBackgroundMusic:(NSString *)filePath;


/** 切换视频清晰度 */
- (void)switchVideoQuality;

/** 切换美颜开关 */
- (void)switchBeauty;

/** 切换静音开关 */
- (void)swithMute;

/** 切换镜像开关 */
- (void)swithMirror;

/** 切换摄像头 */
- (void)switchCamera;

/** 切换屏幕方向 */
- (void)switchScreenOrientation;

@end

NS_ASSUME_NONNULL_END
