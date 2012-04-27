//
//  Rect.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rectangle.h"
#import "Line.h"

@implementation Rectangle

@synthesize topLeft, height, width;

-(CGPoint)topRight {
    return (CGPoint){topLeft.x + width, topLeft.y};
}

-(CGPoint)bottomLeft {
    return (CGPoint){topLeft.x, topLeft.y + height};
}

-(CGPoint)bottomRight {
    return (CGPoint){topLeft.x + width, topLeft.y + height};
}

+(Rectangle *)rectangleWithX:(CGFloat)x andY:(CGFloat)y andHeight:(CGFloat)height andWidth:(CGFloat)width {
    Rectangle *rect = [Rectangle alloc];
    rect.topLeft = (CGPoint){x, y};
    rect.height  = height;
    rect.width   = width;
    return rect;
}

-(Boolean)contains:(CGPoint)point {
    return point.x >= topLeft.x && point.x <= (topLeft.x + width)
        && point.y >= topLeft.y && point.y <= (topLeft.y + height);
}


-(Boolean)intersectsRectangle:(Rectangle *)rect {
    return [[Line withPoint:self.topLeft    andPoint:self.topRight]    intersectsRectangle:rect] ||
           [[Line withPoint:self.topRight   andPoint:self.bottomRight] intersectsRectangle:rect] ||
           [[Line withPoint:self.bottomLeft andPoint:self.bottomRight] intersectsRectangle:rect] ||
           [[Line withPoint:self.topLeft    andPoint:self.bottomLeft]  intersectsRectangle:rect];
}

@end
