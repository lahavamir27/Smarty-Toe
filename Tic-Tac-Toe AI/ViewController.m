//
//  ViewController.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "ViewController.h"
#define GOLDEN_RATIO 0.618
#define WIDTH_RATIO 0.8

@interface ViewController () <GameBoardUIDataSource,GameBoardUIDelegate>

@property (nonatomic,strong) UICollectionView *gameBoardUI;
@property (nonatomic) NSInteger playerTurn;
@property (nonatomic,strong) Board *boardModel;
@property (nonatomic,strong) GameBoardUI *boardUI;
@property (nonatomic,strong) AI *computer;
@property (nonatomic) TTTGameMode gameMode;



@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated
{
    
    _boardUI = [[GameBoardUI alloc]initWithFrame:self.view.bounds andDataSource:self];
    _boardUI.delegate =self;
    [self.view addSubview:_boardUI];
    
    Player *player1 = [[Player alloc]initWithOwner:computer];
    Player *player2 = [[Player alloc]initWithOwner:human];
    NSLog(@"%lu",(long)[player1 getPlayerNumber]);
    _playerTurn = [player1 getPlayerNumber];
    
    
    [self createResetButton];
    
    _gameMode = 0;
    _boardModel = [[Board alloc]init];
    NSInteger winner = [_boardModel winner];
    NSLog(@"the winner is number: %ld",(long)winner);
    NSLog(@"is game complete %d",[_boardModel isGameComplete]);
}


-(void)createResetButton
{
    UIButton *button = [[UIButton alloc ]initWithFrame:CGRectMake(12, 12, 40, 40)];
    [button addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"X" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}


-(void)changeCurrentPlayer
{
    if (_playerTurn == 1) {
        _playerTurn = 2;
    }else
    {
        _playerTurn = 1;
    }
}
-(void)resetGame
{
    if ([_boardModel isGameComplete]) {
        [_boardModel resetBoard];
        [_boardUI updateBoardUI];
    }
}

-(void)buttonPressed:(TTTGameMode)gameMode atIndex:(NSInteger)index
{
    switch (gameMode) {
        case 0:
            NSLog(@"single Player Move");
            [self placeMoveAtIndex:index];
            break;
           
        case 1:
            NSLog(@"Two Player Move");
            break;
        default:
            
            break;
    }
}

-(void)placeMoveAtIndex:(NSInteger)index
{
    if ([[_boardModel getGrid][index]  isEqual:@0])
    {
        if (_playerTurn == 1)
        {
            [_boardModel placeMove:boardMark0 atIndex:index];
            NSInteger bestMove = [_computer bestMove:medium currentBoard:_boardModel];
            
            if (bestMove !=  -1 && ![_boardModel isGameComplete])
            {
                [_boardModel placeMove:boardMarkX atIndex:bestMove];
            }
        }
    }
}

#pragma mark -  delegate UI methods

-(void)isGameHaveWinner
{
    NSLog(@"the winner is %ld",(long)[_boardModel winner]);

}

-(void)cellPress:(GameBoardUI *)cell withCellNumber:(NSInteger)index
{
    if (![_boardModel isGameComplete])
    {
        [self buttonPressed:_gameMode atIndex:index];
        [self isGameHaveWinner];
    }
    
    



}

-(NSMutableArray*)getBoard:(GameBoardUI*)board;
{
    return  [_boardModel getGrid];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _computer = [[AI alloc]init];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButton:(id)sender
{
    NSLog(@"button Pressed");
    [self resetGame];
}
@end
