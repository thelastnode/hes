//
//  GMServerUpdate.h
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface GMServerUpdate : NSObject {
}

@property(readwrite) Boolean colorValid;
@property(readwrite) int     color;
@property(readwrite) Boolean healthValid;
@property(readwrite) int     health;
@property(readwrite) Boolean scoreValid;
@property(readwrite) int     score;
@property(readwrite) Boolean vibrateValid;
@property(readwrite) int     vibrate;

+(GMServerUpdate *) parseUpdate:(NSData *)data;

@end
