//
//  UserGuideModel.h
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/3.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserGuideItemModel.h"

@interface UserGuideModel : NSObject

@property(nonatomic, strong) NSArray *guideItmes;
@property(nonatomic, copy) NSString *guideVCKey;

@end
