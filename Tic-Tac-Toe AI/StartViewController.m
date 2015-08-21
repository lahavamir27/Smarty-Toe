//
//  FirstViewController.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "StartViewController.h"
#define BACKGROUND_COLOR   Rgb2UIColor(57, 79, 98, 1)
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define WINDOW_SIZE_WIDTH  self.view.frame.size.width
#define WINDOW_SIZE_HEIGHT  self.view.frame.size.height
#define FONT(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]
#define LOGO_SIZE  self.view.frame.size.width*.55


@interface StartViewController ()<ButtomButtonDelegate>

@property (nonatomic,strong) UILabel *divider;
@property (nonatomic,strong) UILabel *square;
@property (nonatomic,strong) UILabel *player1Labal;
@property (nonatomic,strong) UILabel *player2Labal;
@property (nonatomic,strong) UILabel *vsLabel;
@property (nonatomic,strong) UILabel *circle;



@property (nonatomic,strong) UIButton *player1Humen;
@property (nonatomic,strong) UIButton *player2Humen;
@property (nonatomic,strong) UIButton *player1Computer;
@property (nonatomic,strong) UIButton *player2Computer;
@property (nonatomic,strong) UIButton *player2Frined;
@property (nonatomic) BOOL player1human;
@property (nonatomic) BOOL player2human;

@property (nonatomic,strong) UIView *container;
@property (nonatomic,strong) UIView *headerContainer;

@property (strong,nonatomic) UIViewController *modal;

@property (nonatomic,strong) LogoView *logo;
@property (nonatomic,strong) ButtomButton *startGameButton;
@property BOOL test;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self registerAsObserver];
    [self initContainer];
    [self initHeaderContainer];

    

    // Do any additional setup after loading the view.
}

-(void)initContainer
{
    double ratio = 0.64;
    double width = WINDOW_SIZE_WIDTH;
    double const top = WINDOW_SIZE_HEIGHT* ratio;
    double height = WINDOW_SIZE_HEIGHT * (1-ratio) - 60;
    if (IPAD) {
        width = WINDOW_SIZE_WIDTH/2;
        ratio = 0.75;
        height = WINDOW_SIZE_HEIGHT * (1-ratio) - 60;
    }
    if (!_container) {
        _container = [[UIView alloc]initWithFrame:CGRectMake(0, top, width, height)];
//        _container.backgroundColor = [UIColor redColor];
        [self.view addSubview:_container];
    }
    if (IPAD) {
        _container.center = CGPointMake(width, _container.frame.origin.y+_container.frame.size.height/2);
    }
}

-(void)animateContainer
{
    if (_container) {
        _container.transform = CGAffineTransformMakeTranslation(0, + WINDOW_SIZE_HEIGHT * (1-0.64));
        [UIView animateWithDuration:.7 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            _container.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)initHeaderContainer
{
    double width = WINDOW_SIZE_WIDTH;

    if (IPAD) {
        width = WINDOW_SIZE_WIDTH/2;
    }
    if (!_headerContainer) {
        _headerContainer = [[UIView alloc ]initWithFrame:CGRectMake(0, WINDOW_SIZE_HEIGHT*.64-25, width, 25)];
        [self.view addSubview:_headerContainer];
    }
    if (IPAD) {
        _headerContainer.center = CGPointMake(width, _headerContainer.frame.origin.y+_headerContainer.frame.size.height/2);
    }
}


-(void)animateHeaderContainer
{
    
    if (_headerContainer) {
        double const drop = WINDOW_SIZE_HEIGHT - _headerContainer.frame.origin.y;
        _headerContainer.transform = CGAffineTransformMakeTranslation(0, + drop);
        [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            _headerContainer.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)registerAsObserver
{
    
    
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"player1human"];
    [self addObserver:self forKeyPath:@"player1human" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
    
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"player2human"];
    [self addObserver:self forKeyPath:@"player2human" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if (_player2human == NO && _player1human == NO) {
        _startGameButton.userInteractionEnabled = NO;
        [_startGameButton setButtomButtonColor:Rgb2UIColor(55  , 75, 92, 1) withAnimation:YES];
        [_startGameButton setTitle:@"at least 1 human player"];
    }else
    {
        _startGameButton.userInteractionEnabled = YES;
        [_startGameButton setButtomButtonColor:Rgb2UIColor(75, 170, 221, 1) withAnimation:YES];
        [_startGameButton setTitle:@"New Game"];


    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupUI];
    [self setGameModeStatusWithGameMode:_gameMode];
}


-(void)setGameModeStatusWithGameMode:(TTTGameMode)gameMode
{
    switch (gameMode)
    {
        case xHumanOComputer:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Humen afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Computer afterDelay:0];
            break;
            
        case xHumanOHuman:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Humen afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Humen afterDelay:0];
            break;
            
        case xComputerOhuman:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Computer afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Humen afterDelay:0];
            break;
            
    }
}
-(void)setupUI
{
    [self initLogo];
    
 //   [self initButtomButton];
    [self addDivider];
    [self initPlayersLabel];
    [self addButtons];
    [self initSquare];
    [self initCircle];
    [self animateHeaderContainer];
    [self animateContainer];
    [self performSelector:@selector(initButtomButton) withObject:nil afterDelay:.35];
 //   [self performSelector:@selector(initLogo) withObject:nil afterDelay:0];

}

-(void)addSquare
{
    
}

-(void)initLogo
{
    _logo = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, LOGO_SIZE, LOGO_SIZE/4)];
    _logo.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*0.33);
    [self.view addSubview:_logo];
}

-(void)addButtons
{
    double const thired = 0.33;
    double const twoThired = 0.67;
    double const firstRowHeight = _container.frame.size.height * thired;
    double const seconedRowHeight = _container.frame.size.height * twoThired;
//    double const thiredRowHeight = WINDOW_SIZE_HEIGHT*.805;
    double const xGap = 95;
    double const buttonHeight = 33;
    double const buttonWidth = 80;
    double const width = _container.frame.size.width;

    
    if (!_player1Humen) {
        _player1Humen = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player1Humen];
//        _player1Humen.backgroundColor = [UIColor redColor];
        _player1Humen.titleLabel.font = FONT(15);
        _player1Humen.center = CGPointMake(xGap, firstRowHeight);
        _player1Humen.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_player1Humen setTitle:@"human" forState:UIControlStateNormal];
        [_player1Humen addTarget:nil action:@selector(player1DidPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    if (!_player2Humen) {
        _player2Humen = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player2Humen];
        _player2Humen.titleLabel.font = FONT(15);
        _player2Humen.center = CGPointMake(width-xGap, firstRowHeight);
        _player2Humen.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_player2Humen addTarget:nil action:@selector(player2DidPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_player2Humen setTitle:@"human" forState:UIControlStateNormal];
        [_player2Humen setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];

    }
  
    if (!_player1Computer) {
        _player1Computer = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player1Computer];
        _player1Computer.center = CGPointMake(xGap, seconedRowHeight);
        _player1Computer.titleLabel.font = FONT(15);
        _player1Computer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_player1Computer addTarget:nil action:@selector(player1DidPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_player1Computer setTitle:@"computer" forState:UIControlStateNormal];
        [_player1Computer setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];


    }
    
    if (!_player2Computer) {
        _player2Computer = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player2Computer];
        _player2Computer.center = CGPointMake(width-xGap, seconedRowHeight);
        
        _player2Computer.titleLabel.font = FONT(15);
        _player2Computer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_player2Computer addTarget:nil action:@selector(player2DidPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_player2Computer setTitle:@"computer" forState:UIControlStateNormal];


    }
    
//    if (!_player2Frined) {
//        _player2Frined = [[UIButton alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH-xGap-100,thiredRowHeight , 100, buttonHeight)];
//        _player2Frined.titleLabel.font = FONT(15);
//        _player2Frined.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [_player2Frined setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];
//        [_player2Frined setTitle:@"friend's iPhone" forState:UIControlStateNormal];
//        //[self.view addSubview:_player2Frined];
//    }
}

-(IBAction)player1DidPressed:(id)sender
{
    if (sender == _player1Humen) {
        [_player1Computer setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];
        [_player1Humen setTitleColor:Rgb2UIColor(255, 255, 255,1) forState:UIControlStateNormal];
        _square.center = CGPointMake(27.5, _player1Humen.center.y);
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"player1human"];
        
    }else
    {
        [_player1Computer setTitleColor:Rgb2UIColor(255, 255, 255,1) forState:UIControlStateNormal];
        [_player1Humen setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];
        _square.center = CGPointMake(27.5, _player1Computer.center.y);
        [self setValue:[NSNumber numberWithBool:NO] forKey:@"player1human"];

    }
}

-(IBAction)player2DidPressed:(id)sender
{
    double const width = _container.frame.size.width;

    if (sender == _player2Humen) {
        [_player2Computer setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];
        [_player2Humen setTitleColor:Rgb2UIColor(255, 255, 255,1) forState:UIControlStateNormal];
        _circle.center = CGPointMake(width  - 27.5, _player2Humen.center.y);
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"player2human"];

        
    }else
    {
        [_player2Computer setTitleColor:Rgb2UIColor(255, 255, 255,1) forState:UIControlStateNormal];
        [_player2Humen setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];
        _circle.center = CGPointMake(width - 27.5, _player2Computer.center.y);
        [self setValue:[NSNumber numberWithBool:NO] forKey:@"player2human"];
    }
}

-(TTTGameMode)getGameMode
{
    _gameMode = -1;
    
    if (_player1human && _player2human) {
        return  xHumanOHuman;
    }else if (_player1human && !_player2human)
    {
        return xHumanOComputer;
    }else if (!_player1human && _player2human)
    {
        return xComputerOhuman;
    }
    
    return _gameMode;
}

-(void)initSquare
{
    
    _square = [[UILabel alloc] initWithFrame:CGRectMake(150, 150,(int) 15,15)];
    _square.layer.borderWidth = 2.5;
    _square.layer.borderColor = [UIColor redColor].CGColor;
    _square.layer.borderColor = Rgb2UIColor(95, 200, 235, 1).CGColor;
    _square.center = CGPointMake(27.5, _player1Humen.center.y);
    [_container addSubview:_square];

}
-(void)initCircle
{
    double const width = _container.frame.size.width;

    _circle = [[UILabel alloc] initWithFrame:CGRectMake(150, 150,(int) 16,16)];
    _circle.layer.borderWidth = 2.5;
    _circle.layer.borderColor = [UIColor redColor].CGColor;
    _circle.layer.borderColor = Rgb2UIColor(240, 166, 220, 1).CGColor;
    _circle.layer.cornerRadius = _circle.frame.size.height/2;
    _circle.center = CGPointMake(width - 27.5, _player2Computer.center.y);

    [_container addSubview:_circle];
    /*
    _circle.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _circle.alpha = 0;

    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:.4 initialSpringVelocity:1 options:0 animations:^{
        _circle.transform = CGAffineTransformMakeScale(1, 1);
        _circle.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
 */
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gamePage"]) {
    GameViewController *vc = [segue destinationViewController ];
    vc.gameMode = [self getGameMode];
    }
    
}

-(void)initPlayersLabel
{
    double const xGap = 20;
    double const labelheight = 25;
    double const labelWidth = 80;
    double const width = _container.frame.size.width;

    if (!_player1Labal) {
        _player1Labal = [[UILabel alloc]initWithFrame:CGRectMake(xGap  , 0, labelWidth, labelheight)];
        _player1Labal.text = @"player 1";
        _player1Labal.font = FONT(13);
        _player1Labal.textColor = Rgb2UIColor(176, 192, 206,1);
        [_headerContainer addSubview:_player1Labal];

    }
    
    if (!_player2Labal) {
        _player2Labal = [[UILabel alloc]initWithFrame:CGRectMake(width-xGap-labelWidth, 0, labelWidth, labelheight)];
        _player2Labal.text = @"player 2";
        _player2Labal.font = FONT(13);
        _player2Labal.textAlignment = NSTextAlignmentRight;
        _player2Labal.textColor = Rgb2UIColor(176, 192, 206,1);
        [_headerContainer addSubview:_player2Labal];

    }
    if (!_vsLabel) {
        _vsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, labelheight)];
        _vsLabel.center = CGPointMake(width/2, _headerContainer.frame.size.height/2);
        _vsLabel.textAlignment = NSTextAlignmentCenter;
        _vsLabel.text = @"vs";
        _vsLabel.font = FONT(15);
        _vsLabel.textColor = Rgb2UIColor(255, 255, 255,1);
        [_headerContainer addSubview:_vsLabel];

    }
}
-(void)initButtomButton
{
    if (!_startGameButton) {
        _startGameButton = [[ButtomButton alloc ]initWithFrame:CGRectMake(0, WINDOW_SIZE_HEIGHT, WINDOW_SIZE_WIDTH, 60)];
    }
    _startGameButton.delegate = self;
    [_startGameButton setTitle:@"New Game"];
    [self.view addSubview:_startGameButton];
    [_startGameButton endGameAnimationUpWithDepth:60];
    
}

-(void)addDivider
{
    double const width = _container.frame.size.width;

    CGRect topDividerframe = CGRectMake(20, _headerContainer.frame.size.height , width - 40, 1);
    
    self.divider = [[UILabel alloc]initWithFrame:topDividerframe];
    self.divider.transform = CGAffineTransformMakeScale(1, 1);
    _divider.backgroundColor=  Rgb2UIColor(127,160,189,.5);
    [_headerContainer addSubview:_divider];

}

-(void)buttonPress:(ButtomButton *)button
{
    if ([self getGameMode] == -1) {
    }else
    {
//        [self performSegueWithIdentifier:@"gamePage" sender:nil];
        [self fadeoutViewController];
    }
}

-(void)fadeoutViewController
{
    
    [UIView animateWithDuration:0.3 delay:0.09 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _logo.transform = CGAffineTransformMakeTranslation(0,+40);
        _logo.alpha = 0;
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"gamePage" sender:nil];

    }];
    
    [UIView animateWithDuration:0.35 delay:0.06 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _headerContainer.transform = CGAffineTransformMakeTranslation(0, WINDOW_SIZE_HEIGHT - _headerContainer.frame.origin.y);
    } completion:^(BOOL finished) {

    }];
    [UIView animateWithDuration:0.30 delay:0.03 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _container.transform = CGAffineTransformMakeTranslation(0, WINDOW_SIZE_HEIGHT - _container.frame.origin.y);
    } completion:^(BOOL finished) {

    }];
    
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{

    } completion:^(BOOL finished) {
    }];
    
    [_startGameButton newGameAnimationDown];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)toggleHalfModal:(UIButton *)sender {
    if (self.childViewControllers.count == 0) {
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"HalfModal"];
        [self addChildViewController:self.modal];
        self.modal.view.frame = CGRectMake(0, 568, 320, 468);
        [self.view addSubview:self.modal.view];
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            self.view.alpha = 0.9;
//            self.view.backgroundColor = Rgb2UIColor(21, 21, 22, 1);

            self.modal.view.frame = CGRectMake(0, WINDOW_SIZE_HEIGHT/2, 320, WINDOW_SIZE_HEIGHT);;

        } completion:^(BOOL finished) {
            [self.modal didMoveToParentViewController:self];
        }];

    }else{
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.modal.view.frame = CGRectMake(0, 568, 320, 508);
            self.view.alpha = 1;
            self.view.backgroundColor = BACKGROUND_COLOR;
        } completion:^(BOOL finished) {
            [self.modal.view removeFromSuperview];
            [self.modal removeFromParentViewController];
            self.modal = nil;
        }];

    }
}
@end
