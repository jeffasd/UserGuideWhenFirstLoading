//
//  NSString+Extension.m
//  jeffasd
//
//  Created by jeffasd on 15-10-18.
//  Copyright (c) 2016年 jeffasd. All rights reserved.
//

#import "NSString+Size.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    if (iOS7) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
    
    
}

//CGSizeMake(textRect.size.width, INFINITY) [UIFont systemFontOfSize:UIFont.labelFontSize]
- (CGSize)getLabelTextSizeInGiveSize:(NSString *)string GiveSize:(CGSize)giveSize TextFont:(UIFont *)font
{
    //[UIFont systemFontOfSize:UIFont.labelFontSize]
    NSMutableParagraphStyle *textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:UIColor.blackColor, NSParagraphStyleAttributeName:textStyle};
    CGSize size = [string boundingRectWithSize:giveSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textFontAttributes context:nil].size;
    return size;
}

//获取某种字体的高度
- (CGFloat)getFontHeight: (UIFont *)font
{
    NSString *string = @"zapya";
    NSMutableParagraphStyle *textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:UIColor.blackColor, NSParagraphStyleAttributeName:textStyle};
    CGSize size = CGSizeMake(INFINITY, INFINITY);
    CGFloat fontHeight = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textFontAttributes context:nil].size.height;
    return fontHeight;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
