//
//  Line.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "Shape.h"
#import "Rectangle.h"
#import "Color.h"

@interface Line : Shape {
    CGPoint start;
    CGPoint end;
    CGFloat lineWidth;
    
    Color  *color;
}

@property CGPoint start;
@property CGPoint end;
@property CGFloat lineWidth;

@property(readonly) double angleFromZero;
@property(retain) Color *color;

+(Line *)withPoint:(CGPoint)start andPoint:(CGPoint)end;
+(Line *)withStartX:(int)sx andStartY:(int)sy andEndX:(int)ex andEndY:(int)ey;

-(Boolean)intersectsLine:(Line *)line;

-(Boolean)intersectsRectangle:(Rectangle *)rect;

@end
