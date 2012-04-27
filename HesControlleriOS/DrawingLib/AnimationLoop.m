//
//  AnimationLoop.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnimationLoop.h"
#import <mach/mach_time.h> // for mach_absolute_time

@implementation AnimationLoop

-(id)initWithDelegate:(id<AnimationDelegate>)d {
    self = [super init];
    if (self != nil) {
        delegate   = d;
        mFrameLink = [CADisplayLink displayLinkWithTarget:self
                                                 selector:@selector(doFrame:)];
        mFrameLink.frameInterval = 1;
    }
    return self;
}

double MachTimeToSecs(uint64_t time);

double MachTimeToSecs(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /
    (double)timebase.denom / 1e9;
}

/* Create a new display link object for the main display. It will
 * invoke the method called 'sel' on 'target', the method has the
 * signature '(void)selector:(CADisplayLink *)sender'. */

-(void) doFrame:(id)data
{
    static double bank = 0;
    double frameTime = mFrameLink.duration * mFrameLink.frameInterval;
    bank -= frameTime;
    if( bank > 0 )
    {
        return;
    }
    bank = 0;
    uint64_t nanosStart = mach_absolute_time();
    
    [self->delegate doUpdate:frameTime];
    [self->delegate doRender];
    double elapsed = MachTimeToSecs(mach_absolute_time() - nanosStart);
    
    bank = elapsed;
    if( elapsed > frameTime )
    {
        bank = frameTime + fmod( elapsed, frameTime );
    }
}

-(void) start {
    [mFrameLink addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
}

-(void) stop {
    [mFrameLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
@end
