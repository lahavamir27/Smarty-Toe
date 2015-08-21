//
//  UIColor+ExtendedColorScheme.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 18/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "UIColor+ExtendedColorScheme.h"
#define BACKGROUND_COLOR   Rgb2UIColor(57, 79, 98, 1)
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
@implementation UIColor (ExtendedColorScheme)

+(UIColor*)backgrounDarkBlue
{
    return Rgb2UIColor(57, 79, 98, 1);
}
+(UIColor*)lightBlue
{
    return Rgb2UIColor(95, 200, 235, 1);
}
+(UIColor*)lightPink
{
    return Rgb2UIColor(240, 166, 220, 1);
}
+(UIColor*)dividerColorBlue
{
    return  Rgb2UIColor(127,160,189,.5);
}
+(UIColor*)lightBlueTextColor
{
    return Rgb2UIColor(176, 192, 206,1);
}
@end
