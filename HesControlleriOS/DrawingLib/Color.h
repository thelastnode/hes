//
//  Color.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGColor.h>

@interface Color : NSObject

-(CGColorRef)getCGColor;

@end

@interface RGBColor : Color {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
}

+(RGBColor *)initWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue andAlpha:(CGFloat)alpha;

+(RGBColor *)initWithInt32:(UInt32)int32;

@end

//populated in the RGBColor initialize method

#define kColorRed   ([RGBColor initWithRed:1.0 andGreen:0.0 andBlue:0.0 andAlpha:1.0]) 
#define kColorGreen ([RGBColor initWithRed:0.0 andGreen:1.0 andBlue:0.0 andAlpha:1.0])
#define kColorBlue  ([RGBColor initWithRed:0.0 andGreen:0.0 andBlue:1.0 andAlpha:1.0])
#define kColorBlack ([RGBColor initWithRed:0.0 andGreen:0.0 andBlue:0.0 andAlpha:1.0])
#define kColorWhite ([RGBColor initWithRed:1.0 andGreen:1.0 andBlue:1.0 andAlpha:1.0])

//const Color *kColorRed;
//const Color *kColorBlue;
//const Color *kColorGreen;
//const Color *kColorBlack;
//const Color *kColorWhite;