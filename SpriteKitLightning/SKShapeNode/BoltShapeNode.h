//
//  BoltShapeNode.h
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BoltShapeNode : SKShapeNode

@property (nonatomic) SKShapeNode *shadowNode;

- (instancetype)initWithBezierPath:(UIBezierPath *)bezierPath lifetime:(float)lifetime;

@end
