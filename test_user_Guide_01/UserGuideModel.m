//
//  UserGuideModel.m
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/3.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "UserGuideModel.h"
#import "MJExtension.h"
#import "UserGuideItemModel.h"

@implementation UserGuideModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"guideItmes" : [UserGuideItemModel class]};
}

//- (NSString *)description{
//    
////    @property(nonatomic, strong) NSArray *guideItmes;
////    @property(nonatomic, copy) NSString *guideVCKey;
//    
//    NSString *string = [NSString stringWithFormat:@"<%@-%p>guideItems:%@, guideVCKey:%@", [self class], self, _guideItmes, _guideVCKey];
//    return string;
//}

MJExtensionLogAllProperties

@end
