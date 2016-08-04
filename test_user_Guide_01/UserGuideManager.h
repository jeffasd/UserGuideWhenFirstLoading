//
//  UserGuidManager.h
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/1.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserGuideFocusTypeMode)
{
    UserGuideFocusTypeModeNone = 0,
    UserGuideFocusTypeModeRound,
    UserGuideFocusTypeModeRect,
    UserGuideFocusTypeModeArc,
}; // 用户引导焦点视图类型


@interface UserGuideManager : NSObject

+(instancetype)shareGuideManage;

- (void)showItemsInView:(UIView *)view VCKeyStr:(NSString *)vcKeyStr FinishBlock:(void(^)())block;

@end
