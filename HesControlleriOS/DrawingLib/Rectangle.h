//
//  Rect.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"

@interface Rectangle : Shape {
@private

    CGPoint topLeft;
    CGFloat  height;
    CGFloat  width;
}

@property (readwrite) CGPoint topLeft;
@property (readonly)  CGPoint topRight;
@property (readonly)  CGPoint bottomLeft;
@property (readonly)  CGPoint bottomRight;

@property CGFloat height;
@property CGFloat width;

+(Rectangle *)rectangleWithX:(CGFloat)x andY:(CGFloat)y andHeight:(CGFloat)height andWidth:(CGFloat)width;

-(Boolean)contains:(CGPoint)point;

-(Boolean)intersectsRectangle:(Rectangle *)rect;

@end
