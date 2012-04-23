//
//  GMViewController.m
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMViewController.h"

@implementation GMViewController
@synthesize healthView;
@synthesize scoreView;
@synthesize canvas;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)doRender {
    [canvas enqueueShape:btnOne];
    [canvas enqueueShape:btnTwo];
    
    [healthView loadHTMLString:[NSString stringWithFormat:@"&#9829; x %d", health] baseURL:nil];
    [scoreView setText:[NSString stringWithFormat:@"%08d", score]];

    //rerender the canvas
    [canvas setNeedsDisplay];  
}

- (void)doUpdate:(NSTimeInterval)timeInterval {
    NSArray *updates = [server getPendingUpdates];
    for (GMServerUpdate *update in updates) {
        if (update.colorValid) {
            RGBColor *newColor = [RGBColor initWithInt32:update.color];
            btnOne.color = newColor;
            btnTwo.color = newColor;
        }
        
        if (update.healthValid) {
            health = update.health;
        }
        
        if (update.scoreValid) {
            score = update.score;
        }
        
        if (update.vibrateValid) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [canvas initCanvas];
    loop      = [[AnimationLoop alloc] initWithDelegate:self];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = [[UIApplication sharedApplication] statusBarFrame];

    int    radius  = 80; //TODO: make this dependant on the size and pixel density of the screen

    Color *color = [RGBColor initWithRed:0.5 andGreen:1.0 andBlue:0 andAlpha:1];
    btnOne    = [Circle circleWithCenter:CGPointMake(radius, screenRect.size.width - radius - frame.size.height) andRadius:radius andColor:color andFilled:YES];
    btnTwo    = [Circle circleWithCenter:CGPointMake(screenRect.size.height - radius, radius) andRadius:radius andColor:color andFilled:YES];
    
    health = 0;
    score  = 0;
    server = [[GMServerComms alloc] init];
    [server connectToHost:@"localhost" onPort:4000];
    [loop start];
}

- (void)viewDidUnload
{
    [self setCanvas:nil];
    [self setHealthView:nil];
    [self setScoreView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)handleTouchEvent:(NSString *)eventName withTouches:(NSSet *)touches {
    int ii = 0;
    CGPoint leftBtnTouch  = {0.0f, 0.0f},
            rightBtnTouch = {0.0f, 0.0f};

    for (UITouch *touch in touches) {
        CGPoint loc = [touch locationInView:canvas];
        NSLog(@"%@(%d): %f, %f", eventName, ii, loc.x, loc.y);

        if ([btnOne contains:loc]) {
            leftBtnTouch = [btnOne localize:loc withScale:btnOne.radius];
        }
        if ([btnTwo contains:loc]) {
            rightBtnTouch = [btnTwo localize:loc withScale:btnOne.radius];
        }
        ii++;
    }
    //send the button press to the server (note, this is smart enough not to send 0, 0)
    //NOTE: flip all the y's, so that up is positive
    [server pressButtonLeftX:leftBtnTouch.x andLeftY:-leftBtnTouch.y andRightX:rightBtnTouch.x andRightY:-rightBtnTouch.y];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEvent:@"touchesBegan" withTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEvent:@"touchesBegan" withTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self handleTouchEvent:@"touchesBegan" withTouches:touches];
}

@end
