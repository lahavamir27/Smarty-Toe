//
//  GameCellUI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameCellUI.h"


#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface GameCellUI()

@property (nonatomic,strong) UILabel *lbl;

@end


@implementation GameCellUI

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        


    }
    return self;
}

-(void)addLabel
{
    CGFloat size =   self.frame.size.width;
    NSLog(@"%f",size);
    double const ratio = 0.618;
    _lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0,(int) size*ratio,(int) size*ratio)];
    _lbl.textColor = [UIColor clearColor];
    _lbl.textAlignment = NSTextAlignmentCenter;
    _lbl.layer.borderWidth = 8;
    _lbl.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self addSubview:_lbl];

}
-(void)removeLabel
{
    [_lbl removeFromSuperview];
    _lbl = nil;
}
-(void)setLabelTitle:(NSString*)str
{
    _lbl.text = str;
}
-(NSString*)getLableTitle
{
    return  _lbl.text;
}

-(void)setLabelCenter:(CGPoint)center
{
    _lbl.center = center;
}

-(void)colorPink
{
    _lbl.layer.cornerRadius = _lbl.frame.size.height/2;;

    _lbl.layer.borderColor = [UIColor lightPink].CGColor;
    _lbl.alpha = 0;
    _lbl.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _lbl.alpha = 1;
        _lbl.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)setSqureColorBlue
{
    _lbl.layer.borderColor = [UIColor lightBlue].CGColor;
    _lbl.alpha = 0;
    _lbl.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _lbl.layer.cornerRadius = 0;

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _lbl.alpha = 1;
        _lbl.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];

}

@end
