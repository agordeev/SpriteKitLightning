//
//  LightningLine.h
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LightningLine : SKNode

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) float thickness;

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (void)draw;
+ (void)loadSharedAssets;

@end
