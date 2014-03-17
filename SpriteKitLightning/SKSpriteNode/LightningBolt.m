//
//  LightningBolt.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "LightningBolt.h"
#import "LightningLine.h"

void createBolt3(float x1, float y1, float x2, float y2, float displace, NSMutableArray *pathArray) {
    if (displace < 1.8f) {
        CGPoint point = CGPointMake(x2, y2);
        [pathArray addObject:[NSValue valueWithCGPoint:point]];
    }
    else {
        float mid_x = (x2+x1)*0.5f;
        float mid_y = (y2+y1)*0.5f;
        mid_x += (arc4random_uniform(100)*0.01f-0.5f)*displace;
        mid_y += (arc4random_uniform(100)*0.01f-0.5f)*displace;
        createBolt3(x1, y1, mid_x, mid_y, displace*0.5f, pathArray);
        createBolt3(mid_x, mid_y, x2, y2, displace*0.5f, pathArray);
    }
}


@interface LightningBolt()

@property (nonatomic) NSMutableArray *targetPoints;
@property (nonatomic) float lifetime;
@property (nonatomic) float lineDrawDelay;

@end

@implementation LightningBolt

- (instancetype)initWithLifetime:(float)lifetime lineDrawDelay:(float)lineDrawDelay {
    if (self = [super init]) {
        self.targetPoints = [NSMutableArray array];
        self.lifetime = lifetime;
        self.lineDrawDelay = lineDrawDelay;
        NSString *soundFileName = [NSString stringWithFormat:@"shock%d.aiff", arc4random_uniform(6)+1];
        SKAction *playSound = [SKAction playSoundFileNamed:soundFileName waitForCompletion:YES];
        [self runAction:playSound];
    }
    return self;
}

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lifetime:(float)lifetime lineDrawDelay:(float)lineDrawDelay {
    if (self = [self initWithLifetime:lifetime lineDrawDelay:lineDrawDelay]) {
        [self drawBoltFromPoint:startPoint toPoint:endPoint];
    }
    return self;
}

- (void)drawBoltFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint {
    // Dynamically calculating displace
    float hypot = hypotf(fabsf(endPoint.x - startPoint.x), fabsf(endPoint.y - startPoint.y));
    // hypot/displace = 4/1
    float displace = hypot*0.25;
    
    NSMutableArray *pathArray = [NSMutableArray array];
    [pathArray addObject:[NSValue valueWithCGPoint:startPoint]];
    createBolt3(startPoint.x, startPoint.y, endPoint.x, endPoint.y, displace, pathArray);
    for (int i = 0; i < pathArray.count - 1; i = i + 1) {
        [self addLineToBoltWithStartPoint:((NSValue *)pathArray[i]).CGPointValue
                                 endPoint:((NSValue *)pathArray[i+1]).CGPointValue
                                    delay:i*self.lineDrawDelay];
    }
    SKAction *disappear = [SKAction sequence:@[[SKAction waitForDuration:(pathArray.count - 1)*self.lineDrawDelay + self.lifetime],
                                               [SKAction fadeOutWithDuration:0.25],
                                               [SKAction removeFromParent]]];
    [self runAction:disappear];
}

- (void)addLineToBoltWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint delay:(float)delay {
    LightningLine *line = [[LightningLine alloc] initWithStartPoint:startPoint endPoint:endPoint];
    [self addChild:line];
    if (delay == 0) {
        [line draw];
    }
    else {
        SKAction *delayAction = [SKAction waitForDuration:delay];
        SKAction *draw = [SKAction runBlock:^{
            [line draw];
        }];
        [line runAction:[SKAction sequence:@[delayAction, draw]]];
    }
}

@end
