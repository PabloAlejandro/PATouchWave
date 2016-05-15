//
//  ViewController.m
//  TouchWave
//
//  Created by Pau on 15/05/2016.
//  Copyright © 2016 Pablo Alejandro. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Wave.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIButton * button;
@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, weak) IBOutlet UISwitch * switchControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Screen touches

// Setup by detecting touch on controller view
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch * touch = [touches anyObject];
//    UIView * touchView = touch.view;
//    CGPoint touchPoint = [touch locationInView:touchView];
//    
//    if([touchView isEqual:self.view]) {
//        [touchView addWaveAtPoint:touchPoint fillColor:[UIColor blueColor]];
//    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    UIView * touchView = touch.view;
    CGPoint touchPoint = [touch locationInView:touchView];
    
    if([touchView isEqual:self.view]) {
        [touchView addWaveAtPoint:touchPoint fillColor:[UIColor blueColor]];
    }
}

#pragma mark - Private methods

- (void)setup
{
    // Setup by using UITapGestureRecognizer (for UIView subclasses ie. UIButton)
    UITapGestureRecognizer * buttonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnButton:)];
    buttonTap.delegate = self;
    [self.button addGestureRecognizer:buttonTap];
    
    UITapGestureRecognizer * labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnLabel:)];
    labelTap.delegate = self;
    [self.label addGestureRecognizer:labelTap];
    self.label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * switchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnSwitch:)];
    switchTap.delegate = self;
    [self.switchControl addGestureRecognizer:switchTap];
}

- (void)handleTapGestureOnButton:(UIGestureRecognizer *)gesture
{
    CGPoint center = CGPointMake([gesture locationInView:self.button].x, CGRectGetMidY(self.button.bounds));
    [self.button addWaveAtPoint:center fillColor:[UIColor redColor] target:self action:@selector(buttonTouched:)];
}

- (void)handleTapGestureOnLabel:(UIGestureRecognizer *)gesture
{
    CGPoint center = [gesture locationInView:self.label];
    [self.label addWaveAtPoint:center fillColor:[UIColor magentaColor]];
}

- (void)handleTapGestureOnSwitch:(UIGestureRecognizer *)gesture
{
    CGPoint center = [gesture locationInView:self.switchControl];
    [self.switchControl addWaveAtPoint:center fillColor:[UIColor yellowColor]];
}

- (void)buttonTouched:(id)sender
{
    NSLog(@"%s", __func__);
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
