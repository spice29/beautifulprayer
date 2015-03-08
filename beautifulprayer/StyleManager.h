//
//  Appearance.h
//  summonist
//
//  Created by Adrian Domanico on 2/8/15.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
    StyleManager
 
    Stlye class that contains app fonts, colors, styles etc
 */

@interface StyleManager : NSObject

#pragma mark - Colors

+ (UIColor*) mainColor;

+ (UIColor*) altColor;

+ (UIColor*) defaultDarkGrayColor:(CGFloat)alpha;

#pragma mark - Fonts

+ (UIFont*) defaultFontWithSize:(CGFloat)size;

+ (UIFont*) defaultSubFont:(NSString*)subFont WithSize:(CGFloat)size;

#pragma mark - Color Helpers

+ (UIColor*) colorScaledWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor*) colorScaledWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor*) colorWithHexRGB:(NSUInteger)hex;

@end
