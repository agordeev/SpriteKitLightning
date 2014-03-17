//
//  Lightning2.m
//  SpriteKitLightning
//
//  Created by Andrey Gordeev on 3/17/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "Lightning2.h"
#import "BoltLayer.h"

void createBoltPath2(float x1, float y1, float x2, float y2, float displace, UIBezierPath* path) {
    if (displace < 1.5) {
        CGPoint point = CGPointMake(x2, y2);
        [path addLineToPoint:point];
    }
    else {
        float mid_x = (x2+x1)*0.5f;
        float mid_y = (y2+y1)*0.5f;
        mid_x += (arc4random_uniform(100)*0.01f-0.5f)*displace;
        mid_y += (arc4random_uniform(100)*0.01f-0.5f)*displace;
        createBoltPath2(x1, y1, mid_x, mid_y, displace*0.5f, path);
        createBoltPath2(mid_x, mid_y, x2, y2, displace*0.5f, path);
    }
}

@interface Lightning2()

@property (nonatomic) NSMutableArray *paths;
@property (nonatomic) NSMutableArray *targetPoints;

@end

@implementation Lightning2

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.size = size;
        self.anchorPoint = CGPointZero;
        self.alpha = 1.f;
        
        self.paths = [NSMutableArray array];
        self.targetPoints = [NSMutableArray array];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint locationInView = [touch locationInView:self.scene.view];
    
    [self.targetPoints removeAllObjects];
    [self.targetPoints addObject:[NSValue valueWithCGPoint:locationInView]];
    [self startBoltAnimation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint locationInView = [touch locationInView:self.scene.view];
    [self.targetPoints removeAllObjects];
    [self.targetPoints addObject:[NSValue valueWithCGPoint:locationInView]];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self stopBoltAnimation];
}

- (void)startBoltAnimation {
    SKAction *wait = [SKAction waitForDuration:0.15f];
    SKAction *addLightning = [SKAction runBlock:^{
        CGPoint startPoint = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame));
        for (NSValue *value in self.targetPoints) {
            [self addBoltWithStartPoint:startPoint
                               endPoint:value.CGPointValue];
        }
    }];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[addLightning, wait]]] withKey:@"lightning"];
}

- (void)stopBoltAnimation {
    [self removeActionForKey:@"lightning"];
}

- (void)addBoltWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    // Dynamically calculating displace
    float hypot = hypotf(fabsf(endPoint.x - startPoint.x), fabsf(endPoint.y - startPoint.y));
    // hypot/displace = 4/1
    float displace = hypot*0.25;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    
    createBoltPath2(startPoint.x, startPoint.y, endPoint.x, endPoint.y, displace, path);
    
    // Creating bolt
    BoltLayer *layer = [[BoltLayer alloc] initWithBezierPath:path lifetime:0.3f];
    [self.scene.view.layer addSublayer:layer];
    NSString *soundFileName = [NSString stringWithFormat:@"shock%d.aiff", arc4random_uniform(6)+1];
    SKAction *playSound = [SKAction playSoundFileNamed:soundFileName waitForCompletion:YES];
    [self runAction:playSound];
}


@end
