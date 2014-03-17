//
//  LightningLine.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "LightningLine.h"

@implementation LightningLine


- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    if (self = [super init]) {
        self.startPoint = startPoint;
        self.endPoint = endPoint;
        self.thickness = 1.3f;
    }
    return self;
}

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint parentNode:(SKNode*)parentNode {
    if (self = [self initWithStartPoint:startPoint endPoint:endPoint]) {
        [parentNode addChild:self];
        [self draw];
    }
    return self;
}

- (void)draw {
    const float imageThickness = 2.f;
    float thicknessScale = self.thickness / imageThickness;
    CGPoint startPointInThisNode = [self convertPoint:self.startPoint fromNode:self.parent];
    CGPoint endPointInThisNode = [self convertPoint:self.endPoint fromNode:self.parent];
    float angle = atan2(endPointInThisNode.y - startPointInThisNode.y,
                        endPointInThisNode.x - startPointInThisNode.x);
    float length = hypotf(fabsf(endPointInThisNode.x - startPointInThisNode.x),
                          fabsf(endPointInThisNode.y - startPointInThisNode.y));
    
    SKSpriteNode *halfCircleA = [SKSpriteNode spriteNodeWithTexture:[self halfCircle]];
    halfCircleA.anchorPoint = CGPointMake(1, 0.5);
    SKSpriteNode *halfCircleB = [SKSpriteNode spriteNodeWithTexture:[self halfCircle]];
    halfCircleB.anchorPoint = CGPointMake(1, 0.5);
    halfCircleB.xScale = -1.f;
    SKSpriteNode *lightningSegment = [SKSpriteNode spriteNodeWithTexture:[self lightningSegment]];
    halfCircleA.yScale = halfCircleB.yScale = lightningSegment.yScale = thicknessScale;
    halfCircleA.zRotation = halfCircleB.zRotation = lightningSegment.zRotation = angle;
    lightningSegment.xScale = length*2;
    
    //    halfCircleA.alpha = halfCircleB.alpha = 0.8f;
    halfCircleA.blendMode = halfCircleB.blendMode = lightningSegment.blendMode = SKBlendModeAlpha;
    
    halfCircleA.position = startPointInThisNode;
    halfCircleB.position = endPointInThisNode;
    lightningSegment.position = CGPointMake((startPointInThisNode.x + endPointInThisNode.x)*0.5f,
                                            (startPointInThisNode.y + endPointInThisNode.y)*0.5f);
    [self addChild:halfCircleA];
    [self addChild:halfCircleB];
    [self addChild:lightningSegment];
}

+ (void)loadSharedAssets {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sHalfCircle = [SKTexture textureWithImageNamed:@"half_circle"];
        sLightningSegment = [SKTexture textureWithImageNamed:@"lightning_segment"];
    });
}

static SKTexture *sHalfCircle = nil;
- (SKTexture*)halfCircle {
    return sHalfCircle;
}

static SKTexture *sLightningSegment = nil;
- (SKTexture*)lightningSegment {
    return sLightningSegment;
}

@end
