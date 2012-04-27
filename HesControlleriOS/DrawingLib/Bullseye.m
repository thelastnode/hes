//
//  Bullseye.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bullseye.h"

@implementation Bullseye

@synthesize boundingRect;

+(Bullseye *)bullseyeWithCenter:(CGPoint)center
                      andRadius:(double)radius
                       andColor:(Color *)color {
    Bullseye *bullseye = [Bullseye alloc];
    //create the inner ring at 1/2 the radius
    bullseye->inner = [Circle circleWithCenter:center andRadius:(radius/2) andColor:color andFilled:NO];
    bullseye->outer = [Circle circleWithCenter:center andRadius:radius     andColor:color andFilled:NO];
    
    bullseye->hitRegion = [Circle circleWithCenter:center andRadius:(radius/4) andColor:color andFilled:NO];
    bullseye->boundingRect = bullseye->outer.boundingRect;
    
    return bullseye;
}

-(void) draw:(CGContextRef) context into:(CGRect) rect {
    [outer draw:context into:rect];
    [inner draw:context into:rect];
}

-(Boolean) hitBy:(Circle *) circle {
    return [circle encloses:hitRegion];
}

@end
