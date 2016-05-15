//
//  UIView+Wave.h
//  TouchWave
//
//  Created by Pau on 15/05/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Wave)

- (void)addWaveAtPoint:(CGPoint)point fillColor:(UIColor *)fillColor;
- (void)addWaveAtPoint:(CGPoint)point fillColor:(UIColor *)fillColor target:(id)target action:(SEL)action;

@end
