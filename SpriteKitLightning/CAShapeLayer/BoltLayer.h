//
//  BoltLayer.h
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BoltLayer : CALayer

- (instancetype)initWithBezierPath:(UIBezierPath *)bezierPath lifetime:(float)lifetime;

@end
