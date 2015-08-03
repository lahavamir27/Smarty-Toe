//
//  ButtomButton.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "ButtomButton.h"
#define FONT_BOLD(a) [UIFont fontWithName:@"JosefinSans-Bold" size:(a)]
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define FONT(a) [UIFont fontWithName:@"Avenir-Medium" size:(a)]

@interface ButtomButton()
@property (nonatomic,strong) UIButton * button;
@end

@implementation ButtomButton



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initButtonWithFrame:frame];
    }
    return  self;
}

-(void)initButtonWithFrame:(CGRect)frame
{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
       
        [_button addTarget:self action:@selector(delegateButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"One More ?" forState:UIControlStateNormal];
        _button.titleLabel.font  = FONT(13);
        [_button setTitleColor:Rgb2UIColor(255, 255, 255, 1) forState:UIControlStateNormal];
        _button.backgroundColor = Rgb2UIColor(75, 170, 221, 1);
        
        [self addSubview:_button];
    }
    
}

-(void)disableButton
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent animations:^{
        _button.backgroundColor = Rgb2UIColor(55  , 75, 92, 1);
        [_button setTitle:@"At least 1 human player" forState:UIControlStateNormal];

    } completion:^(BOOL finished) {


    }];
}
-(void)fixButtonSize
{
    _button.frame = self.bounds;
}

-(void)enableButton
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent animations:^{
        _button.backgroundColor = Rgb2UIColor(75, 170, 221, 1);
        [_button setTitle:@"New Game" forState:UIControlStateNormal];

    } completion:^(BOOL finished) {


    }];
}

-(void)setTitle:(NSString*)str
{
    [_button setTitle:str forState:UIControlStateNormal];
}
-(void)delegateButtonPress
{
    NSLog(@"button Pressed");
        [_delegate buttonPress:self];
}


-(void)endGameAnimationUpWithDepth:(NSInteger)depth
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, -depth);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}
-(void)newGameAnimationDown
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, +7);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
