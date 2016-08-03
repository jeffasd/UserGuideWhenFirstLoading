//
//  UserGuideModel.h
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/3.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGuideItemModel : NSObject

@property(nonatomic, copy) NSString *guidItemType;
@property(nonatomic, strong) NSNumber *guidlabelCenterX;
@property(nonatomic, strong) NSNumber *guidlabelCenterY;
@property(nonatomic, copy) NSString *guidLabelStr;
@property(nonatomic, strong) NSNumber *guidLabelFont;
@property(nonatomic, strong) NSNumber *guidImageCenterX;
@property(nonatomic, strong) NSNumber *guidImageCenterY;
@property(nonatomic, copy) NSString *guidImageName;
@property(nonatomic, strong) NSNumber *guidBtnCenterX;
@property(nonatomic, strong) NSNumber *guidBtnCenterY;
@property(nonatomic, copy) NSString *guidBtnStr;
@property(nonatomic, copy) NSString *guidBtnImageName;
@property(nonatomic, copy) NSString *guidBtnType;

@end
