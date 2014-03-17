//
//  Scene1.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "Scene1.h"
#import "Lightning1.h"

@implementation Scene1

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        Lightning1 *lightning = [[Lightning1 alloc] initWithSize:size];
        lightning.position = CGPointZero;
        
        [self addChild:lightning];
    }
    return self;
}

@end
