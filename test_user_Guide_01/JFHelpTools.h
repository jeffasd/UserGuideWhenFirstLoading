//
//  JFHelpTools.h
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/3.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCurrentVersion    @"movieSlice.kVersion"

#define kCurrentVersionIsFirstLoading    @"movieSlice.kCurrentVersionIsFirstLoading"

@interface JFHelpTools : NSObject

+ (BOOL)currentVersionIsFirstLoading;

@end
