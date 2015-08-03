//
//  ButtomScoreBoard.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 19/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "ButtomScoreBoard.h"

#define WINDOW_SIZE_HEIGHT  self.window.frame.size.height
#define WINDOW_SIZE_WIDTH  self.frame.size.width
#define FONT_LIGHT(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]
#define FONT_THIN(a) [UIFont fontWithName:@"AvenirNext-UltraLight" size:(a)]
#define FONT_REGULAR(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]
#define FONT_BOLD(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]

#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define GREY_COLOR   Rgb2UIColor(176,192,206,1)
#define LIGHT_GREY_COLOR   Rgb2UIColor(231,231,231,1)



#define HEIGHT 143

@interface ButtomScoreBoard()


@property (nonatomic) UILabel *playerXScore;
@property (nonatomic) UILabel *playerOScore;
@property (nonatomic) UILabel *playerXName;
@property (nonatomic) UILabel *playerOName;
@property (nonatomic) UILabel *twoDots;
@property (nonatomic) UIView *playerXIcon;
@property (nonatomic) UIView *playerOIcon;
@property (nonatomic) UILabel *divder;
@property (nonatomic) UILabel *divider;
@property (nonatomic) UILabel *square;
@property (nonatomic) UILabel *circle;



@end
@implementation ButtomScoreBoard

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = Rgb2UIColor(250  , 250, 250, 0);
        [self setupUI];
        
    }
    return self;
}


-(void)setupUI
{
    [self addScores];
    [self addPlayersNames];
    [self addIcons];
    [self addSquare];
    [self addCircle];
   // [self addDivderLabel];
}

-(void)addSquare
{
    _square = [[UILabel alloc] initWithFrame:CGRectMake(15, 30,(int) 25,25)];
    _square.textColor = [UIColor clearColor];
    _square.layer.borderWidth = 5;
    _square.layer.borderColor = [UIColor redColor].CGColor;
    _square.layer.borderColor = Rgb2UIColor(95, 200, 235, 1).CGColor;

    [self addSubview:_square];
}

-(void)addCircle
{
    _circle = [[UILabel alloc] initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH-15-25, 30,(int) 25,25)];

    _circle.textColor = [UIColor clearColor];
    _circle.layer.borderWidth = 5;
    _circle.layer.cornerRadius = _circle.frame.size.height/2;;
    _circle.layer.borderColor = Rgb2UIColor(240, 166, 220, 1).CGColor;
    [self addSubview:_circle];
}

-(void)addTwoDots
{
    if (!_twoDots) {
        
        NSLog(@"%f width",WINDOW_SIZE_WIDTH);
        _twoDots = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH/2-15, 28, 30, 30)];
   //     _twoDots.center = CGPointMake(WINDOW_SIZE_WIDTH/2, 20);
        NSLog(@"two dots");
        [self addSubview:_twoDots];
        _twoDots.text = @":";
        _twoDots.textColor = LIGHT_GREY_COLOR;
        _twoDots.textAlignment = NSTextAlignmentCenter;
        _twoDots.font = FONT_THIN(45);
    }

}

-(void)addScores
{
    if (!_playerXScore) {
        _playerXScore = [[UILabel alloc]initWithFrame:CGRectMake(55, 30, 50, 40)];
        _playerOScore = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH-105, 30, 50, 40)];
        _playerXScore.textAlignment = NSTextAlignmentLeft;
        _playerOScore.textAlignment = NSTextAlignmentRight;
        _playerXScore.text = @"0";
        _playerOScore.text = @"0";
        
        _playerXScore.font = FONT_THIN(24);
        _playerOScore.font = FONT_THIN(24);

        _playerXScore.textColor = [UIColor whiteColor];
        _playerOScore.textColor = [UIColor whiteColor];


        [self addSubview:_playerXScore];
        [self addSubview:_playerOScore];

    }
}

-(void)addPlayersNames
{
    
    int labelSizeX = 50;
    int labelSizeY = 20;
    int yAxies = 15;
    int gap = 100 ;
    int halfScreenSize = self.frame.size.width/2;
    
    if (!_playerXName)
    {
        _playerXName = [[UILabel alloc]initWithFrame:CGRectMake(55, 20, 100, 15)];
        _playerOName = [[UILabel alloc]initWithFrame: CGRectMake(WINDOW_SIZE_WIDTH-155, 20, 100, 15)];
                       
        
        _playerXName.textAlignment = NSTextAlignmentLeft;
        _playerOName.textAlignment = NSTextAlignmentRight;
        
        _playerXName.font = FONT_BOLD(13);
        _playerOName.font = FONT_BOLD(13);
        
        _playerXName.textColor = GREY_COLOR;
        _playerOName.textColor = GREY_COLOR;
        
        _playerXName.text = @"Player 1";
        _playerOName.text = @"Player 2";
        


        int x = _playerXName.frame.size.width;
        // fix player 1 postion

        
        [self addSubview:_playerXName];
        [self addSubview:_playerOName];
        
    }
}

-(void)addIcons
{
    int iconSize = 24;
    if (!_playerXIcon) {
        _playerXIcon = [[UIView alloc]initWithFrame:CGRectMake(_playerXName.frame.origin.x-iconSize, 2, iconSize, iconSize)];
        _playerOIcon = [[UIView alloc]initWithFrame:CGRectMake(_playerOName.frame.origin.x+_playerOName.frame.size.width, 2, iconSize, iconSize)];
        
        
   //     _playerOIcon.backgroundColor = [UIColor redColor];
   //     _playerXIcon.backgroundColor = [UIColor redColor];

        [self addSubview:_playerXIcon];
        [self addSubview:_playerOIcon];

    }
}


-(void)setScoreForPlayerX:(NSInteger)score
{
    _playerXScore.text = [NSString stringWithFormat:@"%lu",(long)score];
}

-(void)setScoreForPlayerO:(NSInteger)score
{
    _playerOScore.text = [NSString stringWithFormat:@"%lu",(long)score];
}

-(void)renamePlayerNames:(NSString*)playerX andPlayerO:(NSString*)playerO
{
    _playerXName.text = playerX;
    _playerOName.text = playerO;
    
   // [_playerXName sizeToFit];
  //  [_playerOName sizeToFit];
    
    CGFloat centerX= _playerOScore.center.x;
//    _playerOName.center  = CGPointMake(centerX, _playerOName.center.y) ;
    
    centerX= _playerXScore.center.x;
//    _playerXName.center  = CGPointMake(centerX, _playerXName.center.y) ;

}

-(void)addDivider
{
    CGRect topDividerframe = CGRectMake(0, 0, 320, 1);
    self.divider = [[UILabel alloc]initWithFrame:topDividerframe];
    self.divider.transform = CGAffineTransformMakeScale(0, 1);
    _divider.backgroundColor= Rgb2UIColor(231, 231, 231, 1);
 //   [self addSubview:_divider];
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.divider.transform = CGAffineTransformMakeScale(1, 1);
                     }   completion:^(BOOL finished) {  }];
}

-(void)fadeInAnimation
{
    self.transform =CGAffineTransformMakeTranslation(0, 44);
    self.alpha = 0;
    [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, 0);
        self.alpha = 1;

    } completion:^(BOOL finished) {
        [self addDivider];
    }];
}

-(void)endGameAnimationUp
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -44);
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)newGameAnimationDown
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, 2);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)endGameAnimationDownWithDepth:(NSInteger)depth
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, depth);
                         
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
