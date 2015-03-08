//
//  Appearance.m
//  summonist
//
//  Created by Adrian Domanico on 2/8/15.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "StyleManager.h"

@implementation StyleManager

#pragma mark - Colors

+ (UIColor*) mainColor {
    return [StyleManager colorScaledWith255Red:255 green:148 blue:49];
}

+ (UIColor*) altColor {
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

+ (UIColor*) defaultDarkGrayColor:(CGFloat)alpha {
    return [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:alpha];
}

#pragma mark - Fonts

+ (UIFont*) defaultFontWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Lato" size:size];
    
}

+ (UIFont*) defaultSubFont:(NSString*)subFont WithSize:(CGFloat)size {
    
    if([subFont isEqualToString:@"Regular"]){
        return [StyleManager defaultFontWithSize:size];
    }
    
    NSString *fontName = [NSString stringWithFormat:@"Lato-%@",subFont];
    return [UIFont fontWithName:fontName size:size];
}

#pragma mark - Color Helpers

+ (UIColor*) colorScaledWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor*) colorScaledWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor*)colorWithHexRGB:(NSUInteger)hex {
    CGFloat ff = 255.f;
    CGFloat r = ((hex & 0xff0000) >> 16) / ff;
    CGFloat g = ((hex & 0xff00) >> 8) / ff;
    CGFloat b = (hex & 0xff) / ff;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
