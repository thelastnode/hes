//
//  Shape.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Shape : NSObject

-(void) draw:(CGContextRef) context into:(CGRect) rect;

@end
