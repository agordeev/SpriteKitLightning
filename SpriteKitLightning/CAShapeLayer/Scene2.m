//
//  Scene2.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "Scene2.h"
#import "Lightning2.h"

@implementation Scene2

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        Lightning2 *lightning = [[Lightning2 alloc] initWithSize:size];
        lightning.position = CGPointZero;

        [self addChild:lightning];
    }
    return self;
}

@end
