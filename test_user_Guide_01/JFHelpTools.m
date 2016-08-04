//
//  JFHelpTools.m
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/3.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "JFHelpTools.h"

@implementation JFHelpTools

+ (BOOL)currentVersionIsFirstLoading{
    
    BOOL isFirstLoading = [[NSUserDefaults standardUserDefaults] boolForKey:kCurrentVersionIsFirstLoading];
    
    NSString *standBoxVersionStr = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentVersion];
    
    NSLog(@"standBoxVersionStr is %@", standBoxVersionStr);
    
    return isFirstLoading;
}

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        //根据版本特性来比较 App是否是第一次启动
        [self compareCurrentVersionToStandBoxVersion];
    });
    
}

//内部方法 外部不能调用
+ (void)compareCurrentVersionToStandBoxVersion{
    
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentVersion];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *versionString = infoDic[@"CFBundleShortVersionString"];
    
    if (currentVersion == nil) {
        
        [[NSUserDefaults standardUserDefaults] setValue:versionString forKey:kCurrentVersion];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCurrentVersionIsFirstLoading];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        
        NSArray *strArrPlist = [versionString componentsSeparatedByString:@"."];
        NSString *standBoxVersionStr = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentVersion];
        NSArray *strArrStandBox = [standBoxVersionStr componentsSeparatedByString:@"."];
        
        BOOL isNew = NO;
        if (strArrPlist.count != strArrStandBox.count) {
            
            isNew = YES;
            [self setStandBoxAppVersion:versionString IsFirstLoading:isNew];
            return;
        }
        
        NSUInteger minCount = strArrPlist.count < strArrStandBox.count ? strArrPlist.count : strArrStandBox.count;
        
        
        for (int i = 0; i < minCount; i++) {
            
//            //当前版本比沙盒版本大
//            if ([strArrPlist[i] intValue] > [strArrStandBox[i] intValue]) {
//                isNew = YES;
//                break;
//            }
            
            //当前版本与沙盒版本不同
            if ([strArrPlist[i] intValue] != [strArrStandBox[i] intValue]) {
                isNew = YES;
                break;
            }
        }
        
        [self setStandBoxAppVersion:versionString IsFirstLoading:isNew];
        
    }
}

+(void)setStandBoxAppVersion:(NSString *)versionStr IsFirstLoading:(BOOL)isFirstLoading{
    
    if (isFirstLoading) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCurrentVersionIsFirstLoading];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kCurrentVersionIsFirstLoading];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:versionStr forKey:kCurrentVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
