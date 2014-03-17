//
//  Scene3.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "Scene3.h"
#import "Lightning3.h"
#import "LightningLine.h"

@implementation Scene3

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor blackColor];
        
        [LightningLine loadSharedAssets];
        
        Lightning3 *lightning = [[Lightning3 alloc] initWithSize:size];
        lightning.position = CGPointZero;
        [self addChild:lightning];
    }
    return self;
}

@end
