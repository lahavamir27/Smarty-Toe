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
#define Iphone4_Iphone4S  WINDOW_SIZE_HEIGHT == 480

@interface StartViewController ()<ButtomButtonDelegate>

@property (nonatomic,strong) UILabel *divider;
@property (nonatomic,strong) UILabel *square;
@property (nonatomic,strong) UILabel *player1Labal;
@property (nonatomic,strong) UILabel *player2Labal;
@property (nonatomic,strong) UILabel *vsLabel;
@property (nonatomic,strong) UILabel *circle;



@property (nonatomic,strong) UIButton *player1Human;
@property (nonatomic,strong) UIButton *player2Human;
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


#pragma mark -  life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self registerAsObserver];
    [self initContainer];
    [self initHeaderContainer];

    

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupUI];
    [self setGameModeStatusWithGameMode:_gameMode];
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
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  init views


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
    if (Iphone4_Iphone4S) {
        ratio = 0.60;
        height = WINDOW_SIZE_HEIGHT * (1-ratio) - 80;
    }
    if (!_container) {
        _container = [[UIView alloc]initWithFrame:CGRectMake(0, top, width, height)];
        [self.view addSubview:_container];
    }
    if (IPAD) {
        _container.center = CGPointMake(width, _container.frame.origin.y+_container.frame.size.height/2);
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


-(void)initSquare
{
    
    _square = [[UILabel alloc] initWithFrame:CGRectMake(150, 150,(int) 15,15)];
    _square.layer.borderWidth = 2.5;
    _square.layer.borderColor = [UIColor lightBlue].CGColor;
    _square.center = CGPointMake(27.5, _player1Human.center.y);
    [_container addSubview:_square];
    
}
-(void)initCircle
{
    double const width = _container.frame.size.width;
    
    _circle = [[UILabel alloc] initWithFrame:CGRectMake(150, 150,(int) 16,16)];
    _circle.layer.borderWidth = 2.5;
    _circle.layer.borderColor = [UIColor redColor].CGColor;
    _circle.layer.borderColor = [UIColor lightPink].CGColor;
    _circle.layer.cornerRadius = _circle.frame.size.height/2;
    _circle.center = CGPointMake(width - 27.5, _player2Computer.center.y);
    
    [_container addSubview:_circle];
    
}


-(void)initLogo
{
    _logo = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, LOGO_SIZE, LOGO_SIZE/4)];
    _logo.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*0.33);
    [self.view addSubview:_logo];
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
        _player1Labal.textColor = [UIColor lightBlueTextColor];
        [_headerContainer addSubview:_player1Labal];
        
    }
    
    if (!_player2Labal) {
        _player2Labal = [[UILabel alloc]initWithFrame:CGRectMake(width-xGap-labelWidth, 0, labelWidth, labelheight)];
        _player2Labal.text = @"player 2";
        _player2Labal.font = FONT(13);
        _player2Labal.textAlignment = NSTextAlignmentRight;
        _player2Labal.textColor = [UIColor lightBlueTextColor];
        [_headerContainer addSubview:_player2Labal];
        
    }
    if (!_vsLabel) {
        _vsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, labelheight)];
        _vsLabel.center = CGPointMake(width/2, _container.frame.size.height/2);
        _vsLabel.textAlignment = NSTextAlignmentCenter;
        _vsLabel.text = @"vs";
        _vsLabel.font = FONT(15);
        _vsLabel.textColor =[UIColor whiteColor];
        [_container addSubview:_vsLabel];
        
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
    _divider.backgroundColor=  [UIColor dividerColorBlue];
    [_headerContainer addSubview:_divider];
    
}

#pragma mark - animation


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

#pragma mark - observe



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
        [_startGameButton setButtomButtonColor:[UIColor darkBlueNavigitonBarColor] withAnimation:YES];
        [_startGameButton setTitle:@"at least 1 human player"];
    }else
    {
        _startGameButton.userInteractionEnabled = YES;
        [_startGameButton setButtomButtonColor:[UIColor lightBlueButtom] withAnimation:YES];
        [_startGameButton setTitle:@"New Game"];


    }
    
    
}







#pragma mark - controllers



-(void)addButtons
{
    double const thired = 0.30;
    double const twoThired = 0.70;
    double const firstRowHeight = _container.frame.size.height * thired;
    double const seconedRowHeight = _container.frame.size.height * twoThired;
    double const xGap = 95;
    double const buttonHeight = 44;
    double const buttonWidth = 80;
    double const width = _container.frame.size.width;

    
    if (!_player1Human) {
        _player1Human = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player1Human];
        _player1Human.titleLabel.font = FONT(15);
        _player1Human.center = CGPointMake(xGap, firstRowHeight);
        _player1Human.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_player1Human setTitle:@"human" forState:UIControlStateNormal];
        [_player1Human addTarget:nil action:@selector(player1DidPressed:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    if (!_player2Human) {
        _player2Human = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [_container addSubview:_player2Human];
        _player2Human.titleLabel.font = FONT(15);
        _player2Human.center = CGPointMake(width-xGap, firstRowHeight);
        _player2Human.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_player2Human addTarget:nil action:@selector(player2DidPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_player2Human setTitle:@"human" forState:UIControlStateNormal];
        [_player2Human setTitleColor:Rgb2UIColor(176, 192, 206,1) forState:UIControlStateNormal];

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

}


#pragma mark -  delegate


-(void)buttonPress:(ButtomButton *)button
{
    if ([self getGameMode] == -1) {
    }else
    {
//        [self performSegueWithIdentifier:@"gamePage" sender:nil];
        [self fadeoutViewController];
    }
}

#pragma mark -  action


-(IBAction)player1DidPressed:(id)sender
{
    double const gap = 27.5;
    
    if (sender == _player1Human) {
        [_player1Computer setTitleColor:[UIColor lightBlueTextColor] forState:UIControlStateNormal];
        [_player1Human setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _square.center = CGPointMake(gap, _player1Human.center.y);
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"player1human"];
        
    }else
    {
        [_player1Computer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_player1Human setTitleColor:[UIColor lightBlueTextColor] forState:UIControlStateNormal];
        _square.center = CGPointMake(gap, _player1Computer.center.y);
        [self setValue:[NSNumber numberWithBool:NO] forKey:@"player1human"];
        
    }
}

-(IBAction)player2DidPressed:(id)sender
{
    double const width = _container.frame.size.width;
    double const gap = 27.5;
    
    if (sender == _player2Human) {
        [_player2Computer setTitleColor:[UIColor lightBlueTextColor] forState:UIControlStateNormal];
        [_player2Human setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _circle.center = CGPointMake(width  - gap, _player2Human.center.y);
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"player2human"];
        
        
    }else
    {
        [_player2Computer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_player2Human setTitleColor:[UIColor lightBlueTextColor] forState:UIControlStateNormal];
        _circle.center = CGPointMake(width - gap, _player2Computer.center.y);
        [self setValue:[NSNumber numberWithBool:NO] forKey:@"player2human"];
    }
}

#pragma mark -  segue animation


-(void)fadeoutViewController
{
    
    [UIView animateWithDuration:0.3 delay:0.09 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _logo.transform = CGAffineTransformMakeTranslation(0,+60);
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gamePage"]) {
        GameViewController *vc = [segue destinationViewController ];
        vc.gameMode = [self getGameMode];
    }
    
}


- (IBAction)toggleHalfModal:(UIButton *)sender {
    if (self.childViewControllers.count == 0) {
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"HalfModal"];
        [self addChildViewController:self.modal];
        self.modal.view.frame = CGRectMake(0, 568, 320, 468);
        [self.view addSubview:self.modal.view];
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            self.view.alpha = 0.9;

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



#pragma mark -  helper


-(void)setGameModeStatusWithGameMode:(TTTGameMode)gameMode
{
    switch (gameMode)
    {
        case xHumanOComputer:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Human afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Computer afterDelay:0];
            break;
            
        case xHumanOHuman:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Human afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Human afterDelay:0];
            break;
            
        case xComputerOhuman:
            [self performSelector:@selector(player1DidPressed:) withObject:_player1Computer afterDelay:0];
            [self performSelector:@selector(player2DidPressed:) withObject:_player2Human afterDelay:0];
            break;
            
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

@end
