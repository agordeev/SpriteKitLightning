//
//  Lightning3.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "Lightning3.h"
#import "LightningBolt.h"

@interface Lightning3()

@property (nonatomic) NSMutableArray *targetPoints;

@end


@implementation Lightning3

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointZero;
        self.size = size;
        self.targetPoints = [NSMutableArray array];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint locationInNode = [touch locationInNode:self];
    
    [self.targetPoints removeAllObjects];
    [self.targetPoints addObject:[NSValue valueWithCGPoint:locationInNode]];
    [self startLightning];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint locationInNode = [touch locationInNode:self];
    [self.targetPoints removeAllObjects];
    [self.targetPoints addObject:[NSValue valueWithCGPoint:locationInNode]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self stopLightning];
}

- (void)startLightning {
    SKAction *wait = [SKAction waitForDuration:0.15f];
    SKAction *addLightning = [SKAction runBlock:^{
        CGPoint startPoint = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame));
        for (NSValue *value in self.targetPoints) {
            [self addBoltFromPoint:startPoint
                           toPoint:value.CGPointValue];
        }
    }];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[addLightning, wait]]] withKey:@"lightning"];
}

- (void)stopLightning {
    [self removeActionForKey:@"lightning"];
}


- (void)addBoltFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint{
    LightningBolt *bolt = [[LightningBolt alloc] initWithStartPoint:startPoint
                                                           endPoint:endPoint
                                                           lifetime:0.1f
                                                      lineDrawDelay:0.00175f];
    [self addChild:bolt];
}

@end
