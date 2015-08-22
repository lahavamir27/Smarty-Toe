//
//  NavigationBar.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "NavigationBar.h"

#define FONT_BOLD(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]

#define FONT(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]

#define WINDOW_WIDTH         self.frame.size.width
#define WINDOW_HEIGHT         self.frame.size.height
#define DIVICE_WINDOW_HEIGHT         self.window.frame.size.height



@interface NavigationBar()

@property (nonatomic,strong) UILabel *mainTitle;
@property (nonatomic,strong) UILabel *levelTitle;
@property (nonatomic,strong) UILabel *divider;
@property (nonatomic,strong) UILabel *alert;

@property (nonatomic,strong) UIButton *backButton;

@end

@implementation NavigationBar


#pragma mark - init


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        self.backgroundColor = [UIColor darkBlueNavigitonBarColor];

    }
    return self;
}

-(void)setupUI
{
    [self addMainTitle];
    [self addSubtitle];
    [self addBackButton];
}

#pragma mark - create views


-(void)addAlert:(NSString*)str
{
    if (!_alert) {
        _alert = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    }
    _alert.textAlignment = NSTextAlignmentCenter;
    _alert.alpha = 0;
    _alert.font = FONT(26);
    _alert.text = str;;
    _alert.textColor = [UIColor whiteColor];
    _alert.center = CGPointMake(WINDOW_WIDTH/2, 80);
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
        _mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        _mainTitle.font = FONT_BOLD(13);
        _mainTitle.center = CGPointMake(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
        _mainTitle.textColor = [UIColor whiteColor];
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
        _levelTitle.textColor = [UIColor lightBlueTextColor];
        _levelTitle.textAlignment = NSTextAlignmentRight;
        _levelTitle.text = @"";
        [self addSubview:_levelTitle];
    }
}

-(void)addBackButton
{
    double const imageInsets = 11;
    if (!_backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(2, 2, 44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
        _backButton.imageEdgeInsets =UIEdgeInsetsMake(imageInsets,imageInsets,imageInsets,imageInsets);
        [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
    }
}

#pragma mark - delegate


-(IBAction)buttonPressed:(id)sender
{
    [_delegate backButtonPressed];
}


#pragma mark - setters

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

#pragma mark - animation


-(void)fadeInAnimation
{
    self.transform =CGAffineTransformMakeTranslation(0, -50);
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, 0);
        
    } completion:^(BOOL finished) {
       
    }];
}
-(void)fadeoutAnimation
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -50);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)fadeoutAnimationWithDepth:(NSInteger)depth
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -depth);
        
    } completion:^(BOOL finished) {
        
    }];
}



@end
