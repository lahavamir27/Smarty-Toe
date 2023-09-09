//
//  GameCellUI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameCellUI.h"

@interface GameCellUI()

@property (nonatomic,strong) UILabel *lbl;

@end


@implementation GameCellUI

#pragma mark - init


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
    double const ratio = 0.618;
    _lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0,(int) size*ratio,(int) size*ratio)];
    _lbl.textColor = [UIColor clearColor];
    _lbl.textAlignment = NSTextAlignmentCenter;
    _lbl.layer.borderWidth = 8.0f;
    _lbl.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self addSubview:_lbl];

}
-(void)removeLabel
{
    [_lbl removeFromSuperview];
    _lbl = nil;
}

#pragma mark - setter and getters


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

-(void)setCircleWIthColor
{
    _lbl.layer.cornerRadius = _lbl.frame.size.height/2;;

    _lbl.layer.borderColor = [UIColor lightPink].CGColor;
    _lbl.alpha = 0;
    _lbl.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
      self->_lbl.alpha = 1;
      self->_lbl.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.27 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

    } completion:^(BOOL finished) {
        
    }];
}

-(void)setSqureWithColor
{
    _lbl.layer.borderColor = [UIColor lightBlue].CGColor;
    _lbl.alpha = 0;
    _lbl.transform = CGAffineTransformMakeScale(0.6, 0.6);
    _lbl.layer.cornerRadius = 2;
    _lbl.backgroundColor = [UIColor backgrounDarkBlue];

    
    [UIView animateWithDuration:0.27 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
      self->_lbl.alpha = 1;
      self->_lbl.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
    }];

}

@end
