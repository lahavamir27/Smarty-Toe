//
//  ViewController.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameViewController.h"
#import <Parse/Parse.h>

#define GOLDEN_RATIO 0.618
#define WIDTH_RATIO 0.8
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define BACKGROUND_COLOR   Rgb2UIColor(57, 79, 98, 1)
#define WINDOW_SIZE_HEIGHT  self.view.frame.size.height
#define WINDOW_SIZE_WIDTH  self.view.frame.size.width
#define HEIGHT 68
#define BACKGROUND_COLOR_BRIGHT   Rgb2UIColor(125, 89, 200, 1)
#define FONT_BOLD(a) [UIFont fontWithName:@"JosefinSans-Bold" size:(a)]


@interface GameViewController () <GameBoardUIDataSource,GameBoardUIDelegate,ButtomButtonDelegate,ClockDelegate,NavigationBarDelegate>

@property (nonatomic,strong) UICollectionView *gameBoardUI;
@property (nonatomic) NSInteger playerTurn;
@property (nonatomic,strong) Board *boardModel;
@property (nonatomic,strong) GameBoardUI *boardUI;
@property (nonatomic,strong) AI *computer;
@property (nonatomic,strong) ButtomScoreBoard *scoreBoard;
@property (nonatomic,strong) Player *player1;
@property (nonatomic,strong) Player *player2;
@property (nonatomic,strong) ButtomButton *resetGameButton;
@property (nonatomic,strong) NavigationBar *navBar;
@property (nonatomic,strong) Clock *clock;
@property (nonatomic,strong) GridLines *grid;
@property (nonatomic) BOOL isPlayerFinishMove;
@property (nonatomic) BOOL timeEnd;
@property (nonatomic) BOOL pause;
@property (nonatomic,strong) gameScoreState *state;
@property (nonatomic,strong) levelAlgorithm *levelManager;


@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic, setter=isGameStart:) BOOL gameStart;
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger wins;
@property (nonatomic) NSInteger draw;
@property (nonatomic) NSInteger lost;




@end

@implementation GameViewController

#pragma mark -  life cycle

-(void)saveDataToCluod
{

    PFObject *gameState = [PFObject objectWithClassName:@"game"];
    gameState[@"wins"] = [NSNumber numberWithInteger:[_state getWin]];
    gameState[@"losts"] = [NSNumber numberWithInteger:[_state getLost]];
    gameState[@"drew"] = [NSNumber numberWithInteger:[_state getDraw]];
    gameState[@"gameMode"] = [GameMode convertGameModeToString:_gameMode];
    gameState[@"device"] = [[UIDevice currentDevice] name];
    gameState[@"level"] = [_levelManager convertLevelToString:_level];

    [gameState addObject:[PFUser currentUser] forKey:@"player"];
    
    if ([_state getWin] != 0 || [_state getLost] != 0 || [_state getDraw] !=0 ) {
        [gameState saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (!error)
             {
                 
             }
             else
             {
                 
             }
             
         }
         ];
    }else
    {
        
    }
}
        
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self initBoardModel];
    [self initPlayersWithGameMode:_gameMode];
    _gameStart = NO;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goBackground)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _level = [[_defaults objectForKey:@"level"] integerValue];
    
    if (!_state) {
        _state = [[gameScoreState alloc]init];
    }
    if (!_levelManager) {
        _levelManager = [[levelAlgorithm alloc]init];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)goBackground
{
    if (_clock) {
        [_clock resetTimer];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initBoardUI];
    [self initScoreBoard];
    [self initButtomButton];
    [self initNavigationBar];
    
    

    
    _clock = [[Clock alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 2)];
  //  _clock.center = CGPointMake(160, 85);
    _clock.delegate = self;
    [_navBar addSubview:_clock];
//    [_clock fireCountDown];

    
}
-(void)fontNames
{
    NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++)
    {
//        NSString *fontFamily = [fontFamilies objectAtIndex:i];
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  init


-(void)initNavigationBar
{
    if (!_navBar) {
        _navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, WINDOW_SIZE_WIDTH, 50)];
        [_navBar fadeInAnimation];
        if (_gameMode == xHumanOComputer || _gameMode == xComputerOhuman)
        {
            [_navBar setLevelTitleWithLevel:_level];
        }

        _navBar.delegate = self;
        [self.view addSubview:_navBar];
    }
}

-(void)initScoreBoard
{
    _scoreBoard = [[ButtomScoreBoard alloc] initWithFrame:CGRectMake(0, WINDOW_SIZE_HEIGHT-HEIGHT, WINDOW_SIZE_WIDTH, HEIGHT)];
    [self.view addSubview:_scoreBoard];
    [_scoreBoard fadeInAnimation];
    [_scoreBoard renamePlayerNames:[_player1 getPlayerName] andPlayerO:[_player2 getPlayerName]];

}

-(void)initBoardUI
{
    _boardUI = [[GameBoardUI alloc]initWithFrame:self.view.bounds andDataSource:self];
    _boardUI.delegate =self;
    [self.view addSubview:_boardUI];
    [_boardUI fadeInAnimation];
    [_boardUI updateBoardUI];
}


-(void)initBoardModel
{
    if (!_boardModel) {
        _boardModel = [[Board alloc]init];
    }

}

-(void)initButtomButton
{
    if (!_resetGameButton) {
        _resetGameButton = [[ButtomButton alloc ]initWithFrame:CGRectMake(0, WINDOW_SIZE_HEIGHT, WINDOW_SIZE_WIDTH, 60)];
    }
    _resetGameButton.delegate = self;
    [self.view addSubview:_resetGameButton];

}
-(void)initPlayersWithGameMode:(TTTGameMode)gameMode
{
    _playerTurn = xTurn;
    
    switch (gameMode) {
        case 0:
            _player1 = [[Player alloc]initWithOwner:human];
            _player2 = [[Player alloc]initWithOwner:computer];
            _gameMode = gameMode;
            _computer = [[AI alloc]init];
            break;
        case 1:
            
            _player1 = [[Player alloc]initWithOwner:human];
            _player2 = [[Player alloc]initWithOwner:human];
            _gameMode = gameMode;
            break;
        case 2:
            
            _player1 = [[Player alloc]initWithOwner:computer];
            _player2 = [[Player alloc]initWithOwner:human];
            _gameMode = gameMode;
            _computer = [[AI alloc]init];

            break;
        default:
            break;
    }
}

#pragma mark -  game logic



-(BOOL)isLegalMove:(NSInteger)index
{

    if ([[_boardModel getGrid][index]  isEqual:@0] && _gameStart && !_timeEnd) {
        return YES;
    }
    return NO;
    
}
-(void)isComputerFirst
{
    if (_gameMode == xComputerOhuman)
    {
        [self getComputerBestMove:boardMarkX andBoard:_boardModel];
        _playerTurn = oTurn;
        [_navBar setMainTitleText:@"CIRCLE turn."];
        [_clock fireCountDown];
    }
}

-(void)changeCurrentPlayer
{
    if (_playerTurn == xTurn) {
        _playerTurn = oTurn;
    }else
    {
        _playerTurn = xTurn;
    }
}
-(void)resetGame
{
    if ([_boardModel isGameComplete] || _timeEnd) {
        [_boardModel resetBoard];
        [_scoreBoard newGameAnimationDown];
        [_boardUI newGameAnimationDown];
        [_resetGameButton newGameAnimationDown];
        [_boardUI updateBoardUI];
        _playerTurn = xTurn;
        [_navBar setMainTitleText:@"SQUARE turn."];
        [_navBar removeAlertLabel];
        [_clock resetTimer];
        _timeEnd = NO;
        [self isComputerFirst];
    }
}

-(void)updateState:(TTTPlayerType)winner
{
    if (xHumanOComputer == _gameMode) {
        switch (winner) {
            case -1:
                [_state addLost];
                break;
                
            case 0:
                [_state addDraw];
                break;
                
            case 1:
                [_state addWin];
                break;
                
            default:
                break;
        }
    }
    
    if (xComputerOhuman == _gameMode) {
        switch (winner) {
            case -1:
                [_state addWin];
                break;
                
            case 0:
                [_state addDraw];
                break;
                
            case 1:
                [_state addLost];
                break;
                
            default:
                break;
        }
    }
//    [_state printState];
}

-(void)isGameHaveWinner
{
    
    if ([_boardModel winner] != 0 || [_boardModel isGameComplete]) {
        [_navBar setMainTitleText:@""];
        [_navBar addAlert:@"GAME OVER - DRAW"];
        [_clock resetTimer];
        [self endGameAnimation];
        [self updateState:[_boardModel winner]];
        [self updateLevel];
    }
    switch ([_boardModel winner]) {
        case -1:
            [_player2 addWinning];
            [_navBar addAlert:@"CIRCLE WIN!"];
            [_scoreBoard setScoreForPlayerO:[_player2 getScroe]];
            [_clock resetTimer];
            [self updateLevel];
            break;
            
        case 1:
            [_player1 addWinning];
            [_navBar addAlert:@"SQUARE WIN!"];
            [_scoreBoard setScoreForPlayerX:[_player1 getScroe]];
            [_clock resetTimer];
            [self updateLevel];
            break;
        
            
        default:

            break;
    }
    
    
}



-(void)humanPlaceMoveAtIndex:(NSInteger)index
{

    if ([[_boardModel getGrid][index]  isEqual:@0])
    {
        if (_playerTurn == xTurn)
        {
            [_boardModel placeMove:boardMarkX atIndex:index];
            _isPlayerFinishMove = YES;
        }
        else if (_playerTurn == oTurn)
        {
            [_boardModel placeMove:boardMarkO atIndex:index];
            _isPlayerFinishMove = YES;
        }else
        {
            _isPlayerFinishMove = NO;
        }

    }
}


-(void)getComputerBestMove:(TTTPlayerType)playerType andBoard:(Board*)currBoard
{
    NSInteger bestMove = [_computer bestMove:playerType currentBoard:currBoard andLevel:_level];
    
    if (bestMove !=  -1 && ![_boardModel isGameComplete])
        
    {
        [_boardModel placeMove:playerType atIndex:bestMove];
        [_boardUI updateBoard:bestMove];
    }
}




-(void)updateLevel
{
        long tempLevel = [levelAlgorithm getLevelWithState:_state andLevel:_level];
        if(_level != tempLevel)
        {
            NSString *str = [_levelManager convertLevelToString:tempLevel];
            if (_level < tempLevel )
            {
                [self levelAlert:[NSString stringWithFormat:@"Good job! level up, %@ AI",str]];
            }else
            {

                [self levelAlert:[NSString stringWithFormat:@"level down, %@ AI",str]];

            }
            _level = tempLevel;
            NSNumber *level = [NSNumber numberWithDouble:_level];
            [_defaults setObject:level forKey:@"level"];
            [_state resetState];
        }
        [self updateLevelTitle];
    


}






#pragma mark -  delegate UI methods

-(void)cellPress:(GameBoardUI *)cell withCellNumber:(NSInteger)index
{
    if (![_boardModel isGameComplete] && [self isLegalMove:index])
    {
        [self buttonPressed:_gameMode atIndex:index];
        [self isGameHaveWinner];
    }

}

-(void)animationDidFinishLoad
{
    [self isGameStart:YES];
    [self isComputerFirst];
}
-(void)clockDidFinish
{
    _timeEnd = YES;
    [_navBar addAlert:@"Time's up!"];
    [self endGameAnimation];
    [self updateScoreUI];
}

#pragma mark -  delegate data source methods

-(NSMutableArray*)getBoard:(GameBoardUI*)board;
{
    return  [_boardModel getGrid];
}


#pragma mark -  animation


-(void)endGameAnimation
{
    [_scoreBoard endGameAnimationUp];
    [_boardUI endGameAnimationUp];
    [_resetGameButton endGameAnimationUpWithDepth:60];
    _pause = YES;
    
}

-(void)fadeoutViewController
{
    if (!_pause) {
        [_scoreBoard endGameAnimationDownWithDepth:70];
        [_navBar fadeoutAnimation];
    }else
    {
        [_scoreBoard endGameAnimationDownWithDepth:114];
        [_navBar fadeoutAnimationWithDepth:100];
        
    }
    [_resetGameButton newGameAnimationDown];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _boardUI.alpha = 0;
        _boardUI.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark -  update UI

- (void)levelAlert:(NSString*)str
{
    [_navBar setMainTitleText:str];
}

-(void)updateLevelTitle
{
    if (_gameMode != xHumanOHuman) {
        [_navBar setLevelTitleWithLevel:_level];
    }
}


-(void)updateScoreUI
{
    if (_gameMode == xComputerOhuman)
    {
        [_player1 addWinning];
        [_scoreBoard setScoreForPlayerX:[_player1 getScroe]];
        [_navBar setMainTitleText:@"SQUARE WIN!"];
        }
    
    if (_gameMode == xHumanOComputer)
    {
        [_player2 addWinning];
        [_scoreBoard setScoreForPlayerO:[_player2 getScroe]];
        [_navBar setMainTitleText:@"CIRCLE WIN!"];
    }
    if (_gameMode == xHumanOHuman) {
        if (_playerTurn == xTurn) {
            [_player1 addWinning];
            [_scoreBoard setScoreForPlayerX:[_player1 getScroe]];
            [_navBar setMainTitleText:@"SQUARE WIN!"];
        }else
        {
            [_player2 addWinning];
            [_scoreBoard setScoreForPlayerO:[_player2 getScroe]];
            [_navBar setMainTitleText:@"CIRCLE WIN!"];
        }
    }
    
}

-(void)updateTitle
{
    if (_playerTurn == oTurn || _gameMode == xComputerOhuman) {
        [_navBar setMainTitleText:@"CIRCLE turn."];
    }else
    {
        [_navBar setMainTitleText:@"SQUARE turn."];
        
    }
}

#pragma mark -  action

-(void)buttonPressed:(TTTGameMode)gameMode atIndex:(NSInteger)index
{
    [_clock resetTimer];
    switch (gameMode) {
        case 0:
            [self humanPlaceMoveAtIndex:index];
            [_clock resetTimer];
            if (_isPlayerFinishMove)
            {
                [self getComputerBestMove:boardMarkO andBoard:_boardModel];
                [self updateTitle];
                [_clock fireCountDown];
            }
            _isPlayerFinishMove = NO;
            break;
            
        case 1:

            [self humanPlaceMoveAtIndex:index];
            [_clock resetTimer];
            [self changeCurrentPlayer];
            [self updateTitle];
            [_clock fireCountDown];
            break;
            
        case 2:
            [self humanPlaceMoveAtIndex:index];
            if (_isPlayerFinishMove)
            {
                [_clock resetTimer];
                [self getComputerBestMove:boardMarkX andBoard:_boardModel];
                [self updateTitle];
                [_clock fireCountDown];

            }
            _isPlayerFinishMove = NO;
            
            break;
            
        default:
            
            break;
    }
}

-(void)buttonPress:(ButtomButton *)button
{
    [self resetGame];
    _pause = NO;
}


-(void)backButtonPressed
{
    
    [_clock resetTimer];
    [self saveDataToCluod];
    [self fadeoutViewController];
    [self performSelector:@selector(exitViewController) withObject:nil afterDelay:0.35];
    
}

-(void)exitViewController
{
    [self performSegueWithIdentifier:@"back" sender:nil];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"back"]) {
        GameViewController *vc = [segue destinationViewController ];
        vc.gameMode = _gameMode;
    }
}


@end
