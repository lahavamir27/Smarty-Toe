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


#pragma mark - init

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
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

#pragma mark - create views


-(void)addSquare
{
    double const gap = 15;
    double const kYgap = 30;
    double const squareSize = 25;
    
    _square = [[UILabel alloc] initWithFrame:CGRectMake(gap, kYgap,(int) squareSize,squareSize)];
    _square.textColor = [UIColor clearColor];
    _square.layer.borderWidth = 5;
    _square.layer.borderColor = [UIColor redColor].CGColor;
    _square.layer.borderColor = [UIColor lightBlue].CGColor;

    [self addSubview:_square];
}

-(void)addCircle
{
    double const gap = 15;
    double const kYgap = 30;
    double const circleSize = 25;
    
    _circle = [[UILabel alloc] initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH-gap-circleSize, kYgap,(int) circleSize,circleSize)];
    _circle.textColor = [UIColor clearColor];
    _circle.layer.borderWidth = 5;
    _circle.layer.cornerRadius = _circle.frame.size.height/2;;
    _circle.layer.borderColor = [UIColor lightPink].CGColor;
    [self addSubview:_circle];
}

-(void)addScores
{
    double const gap = 55;
    double const gapRight = 105;
    double const kYgap = 30;
    double const lableSizeWidth = 50;
    double const lableSizeHeight = 40;

    
    if (!_playerXScore) {
        _playerXScore = [[UILabel alloc]initWithFrame:CGRectMake(gap, kYgap, lableSizeWidth, lableSizeHeight)];
        _playerOScore = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH-gapRight, kYgap, lableSizeWidth, lableSizeHeight)];
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
   
    double const gap = 55;
    double const gapRight = 155;
    double const kYgap = 20;
    double const lableSizeWidth = 100;
    double const lableSizeHeight = 15;
    
    if (!_playerXName)
    {
        _playerXName = [[UILabel alloc]initWithFrame:CGRectMake(gap, kYgap, lableSizeWidth, lableSizeHeight)];
        _playerOName = [[UILabel alloc]initWithFrame: CGRectMake(WINDOW_SIZE_WIDTH-gapRight, kYgap, lableSizeWidth, lableSizeHeight)];
                       
        
        _playerXName.textAlignment = NSTextAlignmentLeft;
        _playerOName.textAlignment = NSTextAlignmentRight;
        
        _playerXName.font = FONT_BOLD(13);
        _playerOName.font = FONT_BOLD(13);
        
        _playerXName.textColor = [UIColor lightBlueTextColor];
        _playerOName.textColor = [UIColor lightBlueTextColor];
        
        _playerXName.text = @"Player 1";
        _playerOName.text = @"Player 2";
               
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

#pragma mark - setters and getters



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
    
    CGFloat centerX= _playerOScore.center.x;
    centerX= _playerXScore.center.x;

}

#pragma mark - animation


-(void)fadeInAnimation
{
    self.transform =CGAffineTransformMakeTranslation(0, 60);
    self.alpha = 0;
    [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, 0);
        self.alpha = 1;

    } completion:^(BOOL finished) {
    }];
}

-(void)endGameAnimationUp
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:0 animations:^{
        self.transform =CGAffineTransformMakeTranslation(0, -60);
        
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
