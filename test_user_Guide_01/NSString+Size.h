//
//  NSString+Extension.h
//  jeffasd
//
//  Created by jeffasd on 15-10-18.
//  Copyright (c) 2016年 jeffasd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)getLabelTextSizeInGiveSize:(NSString *)string GiveSize:(CGSize)giveSize TextFont:(UIFont *)font;
- (CGFloat)getFontHeight: (UIFont *)font;
@end
