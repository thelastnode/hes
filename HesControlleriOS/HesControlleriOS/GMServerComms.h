//
//  GMServerComms.h
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMServerUpdate.h"
#import "NSData+Base64.h"

@interface GMServerComms : NSObject<NSStreamDelegate> {
@private
    NSMutableArray *pendingUpdates;
    NSObject       *pendingUpdatesMutex;
    NSInputStream  *inputStream;
    NSOutputStream *outputStream;
}

-(id) init;

-(void) setupStream:(NSStream *)stream;

-(void) connectToHost:(NSString *)host onPort:(int)port;

//-(void) pressButton:(int)button withState: (int)state;
-(void) pressButtonLeftX:(float)lx andLeftY:(float)ly andRightX:(float)rx andRightY:(float)ry;

-(void) readInputStream;

//-(void) listenForHealthUpdate:(void(^)(int))listener;
//
//-(void) listenForUpdate:(void(^)(int))listener;

-(NSArray *) getPendingUpdates;

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;

@end
