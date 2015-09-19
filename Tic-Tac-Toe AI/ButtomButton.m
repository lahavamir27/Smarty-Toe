//
//  ButtomButton.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "ButtomButton.h"

#define FONT(a) [UIFont fontWithName:@"Avenir-Medium" size:(a)]
#define GREY_COLOR   Rgb2UIColor(127,160,189,.5)
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface ButtomButton()
@property (nonatomic,strong) UIButton * button;
@property (nonatomic) UILabel *divider;

@end

@implementation ButtomButton

#pragma mark - init


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
        _button.titleLabel.font  = FONT(15);
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _button.backgroundColor = [UIColor lightBlueButtom];
        [self addSubview:_button];
    }
    
}

-(void)addDivider
{
    CGRect topDividerframe = CGRectMake(0, 0, self.frame.size.width, 1);
    self.divider = [[UILabel alloc]initWithFrame:topDividerframe];
    self.divider.transform = CGAffineTransformMakeScale(0, 1);
    _divider.backgroundColor= GREY_COLOR;
    [self addSubview:_divider];
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.divider.transform = CGAffineTransformMakeScale(1, 1);
                     }   completion:^(BOOL finished) {  }];
}

#pragma mark - setter and getters


-(void)fixButtonSize
{
    _button.frame = self.bounds;
}



-(void)setTitle:(NSString*)str
{
    [_button setTitle:str forState:UIControlStateNormal];
}

-(void)setButtomButtonColor:(UIColor*)color withAnimation:(BOOL)animation;
{
    if (animation) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent animations:^{
            _button.backgroundColor = color;
            
        } completion:^(BOOL finished) {
            
            
        }];
    }else{
        _button.backgroundColor = color;
    }
}

#pragma mark - delegate

-(void)delegateButtonPress
{
        [_delegate buttonPress:self];
}


#pragma mark - animation


-(void)endGameAnimationUpWithDepth:(NSInteger)depth
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction
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


@end
