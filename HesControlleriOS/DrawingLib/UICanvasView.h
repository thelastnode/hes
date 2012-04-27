//
//  UICanvasView.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
#import "Circle.h"
#import "Image.h"
#import "Color.h"

@interface UICanvasView : UIView {
    NSMutableArray *shapes;
}

- (void)initCanvas;

- (void)enqueueShape:(Shape *)shape;

@end
