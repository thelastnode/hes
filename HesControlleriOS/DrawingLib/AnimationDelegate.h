//
//  AnimationDelegate.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AnimationDelegate <NSObject>

-(void)doUpdate:(NSTimeInterval)timeInterval;

-(void)doRender;

@end
