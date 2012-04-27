//
//  GMServerUpdate.m
//  HesControlleriOS
//
//  Created by Jesse Rosalia on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMServerUpdate.h"

@implementation GMServerUpdate

@synthesize color, colorValid, healthValid, health,scoreValid, score, vibrateValid, vibrate;

+(GMServerUpdate *) parseUpdate:(NSData *)data {
    NSError *error = nil;
    NSString* newStr = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];

    //NOTE: the server will send us multiple lines of json at a time...we need to process each separately
    NSArray *parts = [newStr componentsSeparatedByString:@"\n"];
    GMServerUpdate *update = [GMServerUpdate alloc];

    for (NSString *part in parts) {
        NSLog(@"Parsing part %@...\n", part);
        //for some reason, there's an empty part at the end...we cant process this guy
        if (part.length <= 0) {
            continue;
        }
        NSDictionary *json = [NSJSONSerialization 
                              JSONObjectWithData:[part dataUsingEncoding:NSUTF8StringEncoding]
                              
                              options:NSJSONReadingAllowFragments 
                              error:&error];

        if (error != nil) {
            NSLog(@"%@\n", [error localizedFailureReason]);
            NSLog(@"%@\n", [error localizedDescription]);
            return nil;
        }
        NSNumber *vibrate = (NSNumber *)[json objectForKey:@"vibrate"];
        NSNumber *health  = (NSNumber *)[json objectForKey:@"health"];
        NSNumber *score   = (NSNumber *)[json objectForKey:@"score"];
        NSNumber *color   = (NSNumber *)[json objectForKey:@"color"];
        
        if (vibrate != nil) {
            update.vibrateValid = YES;
            update.vibrate = [vibrate intValue];
        }
        if (health != nil) {
            update.healthValid = YES;
            update.health = [health intValue];
        }
        if (score != nil) {
            update.scoreValid = YES;
            update.score = [score intValue];
        }
        if (color != nil) {
            update.colorValid = YES;
            update.color = [color intValue];
        }
    }
    return update;
}
@end
