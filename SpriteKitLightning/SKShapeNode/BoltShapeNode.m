//
//  BoltShapeNode.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "BoltShapeNode.h"

@implementation BoltShapeNode

- (instancetype)initWithBezierPath:(UIBezierPath *)bezierPath lifetime:(float)lifetime {
    if (self = [super init]) {
        self.path = bezierPath.CGPath;
        self.name = @"bolt";
        self.strokeColor = [SKColor whiteColor];
        self.lineWidth = 0.5f;
        self.antialiased = NO;
        
        self.shadowNode = [[SKShapeNode alloc] init];
        self.shadowNode.path = bezierPath.CGPath;
        self.shadowNode.name = @"boltShadow";
        self.shadowNode.strokeColor = [SKColor colorWithRed:0.702 green:0.745 blue:1 alpha:1.0];
        self.shadowNode.lineWidth = 0.5f;
        self.shadowNode.alpha = 0.4;
        self.shadowNode.glowWidth = 5.f;
        [self addChild:self.shadowNode];
        
        SKAction *action1 = [SKAction sequence:@[[SKAction waitForDuration:lifetime],
                                                 [SKAction fadeOutWithDuration:0.25],
                                                 [SKAction removeFromParent]]];
        NSString *soundFileName = [NSString stringWithFormat:@"shock%d.aiff", arc4random_uniform(6)+1];
        //        NSLog(@"%@", soundFileName);
        SKAction *playSound = [SKAction playSoundFileNamed:soundFileName waitForCompletion:YES];
        [self runAction:[SKAction group:@[action1, playSound]]];
    }
    return self;
}

@end
