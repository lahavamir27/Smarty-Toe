//
//  Clock.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 27/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "Clock.h"
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define FONT(a) [UIFont fontWithName:@"JosefinSans" size:(a)]
#define CENTER_VIEW CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
#define CENTER_VIEW_LABEL CGPointMake(self.frame.size.width/2, self.frame.size.height/2+1)

@interface Clock()
{
    float seconedRemain;
    float nextStep;
    float step;

}

@property (nonatomic, strong) UILabel *seconedLbl;
@property (nonatomic) NSTimer *countDownTimer;
@property (strong,nonatomic) CAShapeLayer *redLine;
@property  (nonatomic,strong) CAShapeLayer *pathLayer;

@end

@implementation Clock


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        seconedRemain = 9.9;
   //     [self drewTimerBackgroundCircle];
   //     [self initLabel];
    }
    return  self;
}

-(void)initLabel
{
    if (!_seconedLbl) {
        _seconedLbl =[[UILabel alloc]initWithFrame:CGRectMake(0,0, 17, 17)];
        _seconedLbl.center = CENTER_VIEW_LABEL;
        _seconedLbl.font = FONT(13);
        _seconedLbl.textColor = [UIColor whiteColor];
        _seconedLbl.textAlignment = NSTextAlignmentCenter;
   //     [self addSubview:_seconedLbl];
    }
    else
    {
        seconedRemain = 9.9;
        _seconedLbl.text = [NSString stringWithFormat:@"%d",(int)round(seconedRemain) ];
    }
}

-(void) fireCountDownWithDelay
{
    [self performSelector:@selector(fireCountDown) withObject:nil afterDelay:0.0];
}

-(void)fireCountDown
{
    
    if (!_countDownTimer) {
        _countDownTimer = [[NSTimer alloc]init];
        
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
}

    
}
-(void)timerCountDown
{
    if (seconedRemain>=-0.1) {
        [self drewTimerLine];
        seconedRemain = seconedRemain-0.05;
        int seconed = round(seconedRemain);
        
        if (seconed<10) {
         //   _seconedLbl.text = [NSString stringWithFormat:@"%d",seconed];
            
        }else{
            
         //   _seconedLbl.text = [NSString stringWithFormat:@"%d",seconed];
        }
        
    }else{
        
        NSLog(@" call finish clock");
        [_delegate clockDidFinish];
        [self resetTimer];
        
    }
    
    
    
}


-(void)resetTimer
{
    NSLog(@"reset timer");
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    [UIView animateWithDuration:0.5
                     animations:^{
        _redLine.opacity = 0;

    } completion:^(BOOL finished)
    {
        [self initLabel];
    }];
    

}

-(void)drewTimerLine
{
    //   NSLog(@"drew timer");
    if (!self.redLine) {
        self.redLine = [CAShapeLayer layer];
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    _redLine.opacity = 1;
    
    nextStep = 1-seconedRemain/10;
    self.redLine.frame = self.bounds;
    self.redLine.path = path.CGPath;
    self.redLine.fillColor = [UIColor clearColor].CGColor;
    self.redLine.strokeColor = Rgb2UIColor(95, 200, 235, 1).CGColor;
    //  self.redLine.strokeColor = Rgb2UIColor(0, 0, 0, .7).CGColor;
    self.redLine.lineWidth = 1.5f;
    self.redLine.strokeStart = 0 ;
    self.redLine.strokeEnd = nextStep;
    self.redLine.lineJoin = kCALineCapRound;
    [self.layer addSublayer:self.redLine];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:nextStep];
    pathAnimation.toValue = [NSNumber numberWithFloat:nextStep];
    
    
    [self.redLine addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    step = nextStep;
    
    
}

-(void)drewTimerBackgroundCircle{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    
    _pathLayer = [CAShapeLayer layer];
    _pathLayer.frame = self.bounds;
    _pathLayer.path = path.CGPath;
    _pathLayer.strokeColor = [UIColor colorWithRed:0/255.5 green:171/255.0 blue:156/255.0 alpha:.54].CGColor;
    _pathLayer.fillColor = [UIColor clearColor].CGColor;
    _pathLayer.strokeColor = Rgb2UIColor(176, 192, 206,1).CGColor;
    _pathLayer.lineWidth = 1.0f;
    _pathLayer.lineJoin = kCALineJoinBevel;
    [self.layer addSublayer:_pathLayer];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.2f;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.delegate = self;
    
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
