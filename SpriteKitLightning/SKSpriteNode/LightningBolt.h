//
//  LightningBolt.h
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LightningBolt : SKNode

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lifetime:(float)lifetime lineDrawDelay:(float)lineDrawDelay;

@end
