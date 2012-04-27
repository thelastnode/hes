//
//  AnimationLoop.h
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/CADisplayLink.h"
#import "AnimationDelegate.h"

@interface AnimationLoop : NSObject {

    CADisplayLink *mFrameLink;
    id<AnimationDelegate> delegate;
}

-(id)initWithDelegate:(id<AnimationDelegate>)d;

-(void)start;

-(void)stop;

@end
