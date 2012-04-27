//
//  GMViewController.h
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "UICanvasView.h"
#import "AnimationLoop.h"
#import "AnimationDelegate.h"
#import "GMServerComms.h"

@interface GMViewController : UIViewController<AnimationDelegate> {
@private    
    AnimationLoop  *loop;
    
    Circle         *btnOne;
    Circle         *btnTwo;
    
    GMServerComms  *server;
    int             score;
    int             health;
}

@property (weak, nonatomic) IBOutlet UICanvasView *canvas;

- (void)handleTouchEvent:(NSString *)eventName withTouches:(NSSet *)touches;
@property (weak, nonatomic) IBOutlet UIWebView *healthView;
@property (weak, nonatomic) IBOutlet UITextView *scoreView;

@end
