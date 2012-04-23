//
//  GMServerComms.m
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMServerComms.h"

@implementation GMServerComms

-(id) init {
    self = [super init];
    if (self != nil) {
        self->pendingUpdates = [[NSMutableArray alloc]init];
        self->pendingUpdatesMutex = [[NSObject alloc] init];
    }
    return self;
}

-(void) connectToHost:(NSString *)host onPort:(int)port {
    NSLog(@"Connecting to %@:%d...\n", host, port);
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
    inputStream  = (__bridge_transfer NSInputStream *)readStream;
    outputStream = (__bridge_transfer NSOutputStream *)writeStream;

    [self setupStream:inputStream];
    [self setupStream:outputStream];
    
    [inputStream open];
    [outputStream open];
}

-(void) setupStream:(NSStream *)stream {
    [stream setDelegate:self];
    [stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

//public String toCommand(float x, float y, float x2, float y2) {
//    String ret = "{";
//    if (x != 0.0f || y != 0.0f) {
//        ret += "\"left\": {\"x\":" + x + ", \"y\":" + y + "}";
//    }
//    if (x2 != 0.0f || y2 != 0.0f) {
//        if (ret.length() > 1) {
//            ret += ", ";
//        }
//        ret += "\"right\": {\"x\":" + x2 + ", \"y\":" + y2 + "}";
//    }
//    return ret + "}";
//}

-(void) pressButtonLeftX:(float)lx andLeftY:(float)ly andRightX:(float)rx andRightY:(float)ry {
    
    NSLog(@"Sending left (%f, %f) and right (%f, %f)...\n", lx, ly, rx, ry);

    NSString *str = @"{";
    if (lx != 0.0f || ly != 0.0f) {
        str = [NSString stringWithFormat:@"%@\"left\": {\"x\":%f, \"y\":%f}", str, lx, ly];
    }
    
    if (rx != 0.0f || ry != 0.0f) {
        str = [NSString stringWithFormat:@"%@\"right\": {\"x\":%f, \"y\":%f}", str, rx, ry];
    }

    str = [NSString stringWithFormat:@"%@}", str];

    //	NSString *response  = [NSString stringWithFormat:@"iam:%@", inputNameField.text];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSString *base64 = [data base64EncodedString];
    data = [base64 dataUsingEncoding:NSUTF8StringEncoding];
	[outputStream write:[data bytes] maxLength:[data length]];
    uint8_t eol = '\n';
	[outputStream write:&eol maxLength:1];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    if (eventCode == NSStreamEventHasBytesAvailable && aStream == inputStream) {
        [self readInputStream];
    }
}

- (void)readInputStream {
    uint8_t      buf[4096];
    unsigned int len = 0;

    NSMutableData *data = [[NSMutableData alloc] init];
    int bytesRead = 0;
    
    while (inputStream.hasBytesAvailable) {
        len = [inputStream read:buf maxLength:4096];
        if (len) {
            [data appendBytes:(const void *)buf length:len];
            bytesRead += len;
        }
    }

    GMServerUpdate *update = [GMServerUpdate parseUpdate:data];
    @synchronized(pendingUpdatesMutex) {
        if (update != nil) {
            [pendingUpdates addObject:update];
        }
    }
}

//-(void) listenForHealthUpdate:(void(^)(int))listener {
//    NSLog(@"Listening for health updates\n");
//} 
//
//-(void) listenForScoreUpdate:(void(^)(int))listener {
//    NSLog(@"Listening for score updates\n");    
//}

-(NSArray *) getPendingUpdates {
    
    NSArray *toReturn;
    @synchronized(pendingUpdatesMutex) {
        toReturn = pendingUpdates;
        pendingUpdates = [[NSMutableArray alloc] init];
    }
    return toReturn;
}

@end
