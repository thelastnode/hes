//
//  Circle.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"

@implementation Circle

#pragma mark - Drawing

@synthesize center, color, radius, filled, boundingRect;

+(Circle *)circleWithCenter:(CGPoint)center
                  andRadius:(double)radius
                   andColor:(Color *)color {
    return [Circle circleWithCenter:center andRadius:radius andColor:color andFilled:NO];
}

+(Circle *)circleWithCenter:(CGPoint)center
                  andRadius:(double)radius
                   andColor:(Color *)color
                  andFilled:(Boolean)filled {
    Circle *circle = [Circle alloc];
    circle.center = center;
    circle.radius = radius;
    circle.color  = color;
    circle.filled = filled;

    //read only properties
    circle->boundingRect = [Rectangle rectangleWithX:center.x - radius andY:center.y - radius andHeight:radius * 2 andWidth:radius * 2];
    return circle;
}

-(void) draw:(CGContextRef)context into:(CGRect) rect {
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, [color getCGColor]/*[UIColor blueColor].CGColor*/);
    
    CGRect rectangle = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    
    CGContextAddEllipseInRect(context, rectangle);
    
    if (filled) {
        CGContextSetFillColorWithColor(context, [color getCGColor]);
        CGContextFillEllipseInRect(context, rectangle);
    }

    CGContextStrokePath(context);
}

-(Boolean) contains:(CGPoint) point {
    //compute the distance between the center of the circle and the point
    double dist = sqrt(pow(center.x-point.x, 2) + pow(center.y-point.y, 2));
    //if the distance is less than the circle's radius, then the point is inside the circle
    return dist <= radius;    
}


-(Boolean) encloses:(Circle *)circle {
    //compute the distance between the center of the circles
    double dist = sqrt(pow(center.x-circle.center.x, 2) + pow(center.y-circle.center.y, 2));
    //if the distance plus the circle param's radius is less than this circles radius, we know
    // this circle completely encoloses the circle param
    return dist + circle.radius <= radius;
}

-(CGPoint) localize:(CGPoint)point withScale: (CGFloat)scale {
    CGFloat localX = point.x - center.x;
    CGFloat localY = point.y - center.y;
    
    return CGPointMake(fabs(localX) > radius ? 0 : localX / scale, fabs(localY) > radius ? 0 : localY / scale);
}

@end
