//
//  Bullseye.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"
#import "Circle.h"
#import "Color.h"
#import "Rectangle.h"

@interface Bullseye : Shape {
@private
    Circle    *inner;
    Circle    *outer;
    Circle    *hitRegion;
    Rectangle *boundingRect;
}

@property(readonly) Rectangle *boundingRect;

+(Bullseye *)bullseyeWithCenter:(CGPoint)center
                      andRadius:(double)radius
                       andColor:(Color *)color;


-(void) draw:(CGContextRef) context into:(CGRect) rect;

-(Boolean) hitBy:(Circle *) circle;

@end
