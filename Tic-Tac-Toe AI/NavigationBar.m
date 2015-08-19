//
//  NavigationBar.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "NavigationBar.h"

#define FONT_BOLD(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define DARK_GREY_COLOR   Rgb2UIColor(71,71,71,1)
#define GREY_COLOR   Rgb2UIColor(101,101,101,1)
#define FONT(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]

#define WINDOW_WIDTH         self.frame.size.width
#define WINDOW_HEIGHT         self.frame.size.height



@interface NavigationBar()

@property (nonatomic,strong) UILabel *mainTitle;
@property (nonatomic,strong) UILabel *levelTitle;
@property (nonatomic,strong) UILabel *divider;
@property (nonatomic,strong) UILabel *alert;

@property (nonatomic,strong) UIButton *backButton;

@end

@implementation NavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        self.backgroundColor = Rgb2UIColor(55, 75, 92, 1);

    }
    return self;
}

-(void)setupUI
{
    [self addMainTitle];
    [self addSubtitle];
    [self addBackButton];
}

-(void)addAlert:(NSString*)str
{
    if (!_alert) {
        _alert = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 20)];
    }
    _alert.textAlignment = NSTextAlignmentCenter;
    _alert.alpha = 0;
    _alert.font = FONT(17);
    _alert.text = str;;
    _alert.textColor = [UIColor whiteColor];
    _alert.center = CGPointMake(WINDOW_WIDTH/2, 70);
    [self addSubview:_alert];
    
    _alert.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1 options:0 animations:^{
        _alert.alpha = 1;
        _alert.transform = CGAffineTransformMakeScale(1, 1);

    } completion:^(BOOL finished) {

    }];

}

-(void)removeAlertLabel
{
    if (_alert) {
        
        [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            _alert.alpha = 0;
            _alert.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [_alert removeFromSuperview];
            _alert = nil;
        }];
    }

}

-(void)addMainTitle
{
    if (!_mainTitle) {
        _mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(85, 16, 150, 20)];
        _mainTitle.font = FONT_BOLD(13);
        _mainTitle.center = CGPointMake(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
        _mainTitle.textColor = Rgb2UIColor(255, 255, 255,1);
        _mainTitle.textAlignment = NSTextAlignmentCenter;
        _mainTitle.text = @"SQURE turn.";
        [self addSubview:_mainTitle];
    }
}

-(void)addSubtitle
{
    if (!_levelTitle) {
        _levelTitle = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-96, 16, 80, 20)];
        _levelTitle.font = FONT_BOLD(13);
        _levelTitle.textColor = Rgb2UIColor(176, 192, 206,1);
        _levelTitle.textAlignment = NSTextAlignmentRight;
        _levelTitle.text = @"";
        [self addSubview:_levelTitle];
    }
}

-(void)addBackButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(2, 2, 44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
        _backButton.imageEdgeInsets =UIEdgeInsetsMake(11,11,11,11);
        [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
    }
}

-(IBAction)buttonPressed:(id)sender
{
    [_delegate backButtonPressed];
    NSLog(@"button pressed");
}

-(void)setMainTitleText:(NSString*)str
{
    _mainTitle.text = str;
}

-(void)setLevelTitleWithLevel:(NSInteger)lvl;
{
    switch (lvl) {
        case -1:
            _levelTitle.text = @"";
            break;
            
        case 0:
            _levelTitle.text = @"easy";
            break;
            
        case 1:
            _levelTitle.text = @"medium";
            break;
        case 2:
            _levelTitle.text = @"hard";
            break;
        case 3:
            _levelTitle.text = @"impossible";
            break;
            
        default:
            _levelTitle.text = @"";
            break;
    }
    

}

-(void)fadeInAnimation
{
    self.transform =CGAffineTransformMakeTranslation(0, -50);
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, 0);
        
    } completion:^(BOOL finished) {
       
    }];
}
-(void)fadeoutAnimation
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -50);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)fadeoutAnimationWithDepth:(NSInteger)depth
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -depth);
        
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
