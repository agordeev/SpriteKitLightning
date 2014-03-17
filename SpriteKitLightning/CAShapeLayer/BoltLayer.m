//
//  BoltLayer.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "BoltLayer.h"

@implementation BoltLayer

- (instancetype)initWithBezierPath:(UIBezierPath *)bezierPath lifetime:(float)lifetime {
    if (self = [super init]) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1.f;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.zPosition = 20;
        shapeLayer.shadowColor = [UIColor colorWithRed:0.702 green:0.745 blue:1 alpha:1.0].CGColor;
        shapeLayer.shadowOffset = CGSizeMake(0, 0);
        shapeLayer.shadowRadius = 7.f;
        shapeLayer.shadowOpacity = 1.f;
        shapeLayer.shouldRasterize = YES;
        [self addSublayer:shapeLayer];
        
        CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeOut.delegate = self;
        fadeOut.beginTime = CACurrentMediaTime() + lifetime;
        fadeOut.fromValue = [NSNumber numberWithFloat:1.0];
        fadeOut.toValue = [NSNumber numberWithFloat:0.0];
        fadeOut.duration = 0.25f;
        fadeOut.fillMode = kCAFillModeForwards;
        fadeOut.removedOnCompletion = NO;
        [self addAnimation:fadeOut forKey:@"flashAnimation"];
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if (flag) {
        [self removeFromSuperlayer];
    }
}

@end
