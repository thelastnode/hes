//
//  UICanvasView.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UICanvasView.h"

@implementation UICanvasView

- (id)init {
    self = [super init];
    if (self) {
        [self initCanvas];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCanvas];
    }
    return self;
}

- (void)initCanvas {
    shapes = [[NSMutableArray alloc] init];
}

- (void)enqueueShape:(Shape *)shape {
    [shapes      addObject:shape];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//NOTE: this class expects that things (lines, etc) are loaded onto the canvas before invalidating
// the view...this makes data management easy, as its up to the controller to always push all of the
// data onto the view before drawing, every time
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Drawing code
    for (Shape *shape in shapes) {
        [shape draw:context into:rect];
    }

    //clear the shapes now that they're drawn
    [shapes removeAllObjects];
}

@end
