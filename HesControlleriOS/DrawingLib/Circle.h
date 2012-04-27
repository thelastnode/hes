//
//  Circle.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
#import "Color.h"
#import "Rectangle.h"

@interface Circle : Shape {
@private
    
    CGPoint center;
    Color  *color;
    double  radius;
    Boolean filled;
    Rectangle *boundingRect;
}

@property         CGPoint  center;
@property(retain) Color   *color;
@property         double   radius;
@property         Boolean  filled;
@property(readonly) Rectangle *boundingRect;

+(Circle *)circleWithCenter:(CGPoint)center andRadius:(double)radius andColor:(Color *)color;

+(Circle *)circleWithCenter:(CGPoint)center andRadius:(double)radius andColor:(Color *)color andFilled:(Boolean)filled;

-(Boolean) contains:(CGPoint)point;

-(Boolean) encloses:(Circle *)circle;

-(CGPoint) localize:(CGPoint)point withScale:(CGFloat)scale;
  
@end
