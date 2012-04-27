//
//  Image.m
//  DrawingLib
//
//  Created by Jesse Rosalia on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Image.h"

@implementation Image

-(id)initWithImage:(CGImageRef)i {
    self = [super init];
    if (self != nil) {
        self->image = i;
    }
    return self;
}
-(void) draw:(CGContextRef)context into:(CGRect)rect {
    size_t height = CGImageGetHeight(image);
    size_t width  = CGImageGetWidth(image);
    CGRect imgRect;
    imgRect.origin.x = rect.size.width/2 - width/2;
    imgRect.origin.y = rect.size.height/2 - height/2;
    imgRect.size.height = height;
    imgRect.size.width = width;
    CGContextDrawImage(context, imgRect, image);
}
@end
