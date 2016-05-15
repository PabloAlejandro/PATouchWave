//
//  UIView+Wave.m
//  TouchWave
//
//  Created by Pau on 15/05/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import "UIView+Wave.h"

@implementation UIView (Wave)

#pragma mark - Public methods

- (void)addWaveAtPoint:(CGPoint)point fillColor:(UIColor *)fillColor target:(id)target action:(SEL)action
{
    CAShapeLayer * waveLayer = [self newWaveWithColor:fillColor];
    [self.layer addSublayer:waveLayer];
    
    [self showTapAnimation:point waveLayer:waveLayer];
    
    if(target != nil) {
        if([target respondsToSelector:action]) {
            ((void (*)(id, SEL))[target methodForSelector:action])(target, action);
        }
    }
}

- (void)addWaveAtPoint:(CGPoint)point fillColor:(UIColor *)fillColor
{
    [self addWaveAtPoint:point fillColor:fillColor target:nil action:nil];
}

#pragma mark - Private methods

- (CAShapeLayer *)newWaveWithColor:(UIColor *)fillColor
{
    CAShapeLayer * waveLayer = [CAShapeLayer layer];
    waveLayer.path           = [self frameLayer:CGPointMake(0, 0)].CGPath;
    waveLayer.fillRule       = kCAFillRuleEvenOdd;
    waveLayer.fillColor      = fillColor.CGColor;
    waveLayer.opacity        = 0;
    waveLayer.anchorPoint    = CGPointMake(.5, .5);
    waveLayer.frame          = self.bounds;
    waveLayer.masksToBounds  = YES;
    
    return waveLayer;
}

- (void)showTapAnimation:(CGPoint)center waveLayer:(CAShapeLayer *)waveLayer
{
    waveLayer.path          = [self frameLayer:center].CGPath;
    
    CABasicAnimation * opactityAnimation     = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactityAnimation.fromValue              = [NSNumber numberWithInt:1];
    opactityAnimation.toValue                = [NSNumber numberWithInt:0];
    
    CABasicAnimation * pathAnimation     = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.toValue                = (id)[self bigFrameLayer:center].CGPath;
    
    CAAnimationGroup *group         = [CAAnimationGroup animation];
    group.animations                = @[opactityAnimation, pathAnimation];
    group.duration                  = .8f;
    group.repeatCount               = 0;
    group.autoreverses              = NO;
    group.removedOnCompletion       = YES;
    
    [waveLayer addAnimation:group forKey:@"GroupAnimation"];
}

- (UIBezierPath *)frameLayer:(CGPoint)center {
    CGFloat radius = 20;
    return [UIBezierPath bezierPathWithArcCenter:center radius: radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
}

- (UIBezierPath *)bigFrameLayer:(CGPoint)center {
    CGFloat radius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    return [UIBezierPath bezierPathWithArcCenter:center radius: radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
}

@end
