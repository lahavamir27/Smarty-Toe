//
//  GameBoardUI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameBoardUI.h"
#define GOLDEN_RATIO 0.50
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define GREY_COLOR   Rgb2UIColor(101,101,101,1)
#define BACKGROUND_COLOR   Rgb2UIColor(36, 41, 47, 1)
#define GAME_SIZE  self.frame.size.width*.70
#define GRID_SIZE  self.frame.size.width*.70/3+1

@interface GameBoardUI() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *gameBoardUI;
@property (nonatomic,strong) NSMutableArray * boardArray;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) GridLines * grid;

@end

@implementation GameBoardUI


-(instancetype)initWithFrame:(CGRect)frame andDataSource:(id<GameBoardUIDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        [self showGrid];
        [self createGameBoardUI];
        if (dataSource) _dataSource = dataSource;
        NSLog(@"%f",self.frame.size.width);
    }
    return  self;
}

-(void)createGameBoardUI
{

    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height*(GOLDEN_RATIO));
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _gameBoardUI=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,(int) GAME_SIZE,(int) GAME_SIZE) collectionViewLayout:layout];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0.1;
    
    _gameBoardUI.center = center;
    [_gameBoardUI registerClass:[GameCellUI class] forCellWithReuseIdentifier:@"cellIdentifier"];
    _gameBoardUI.backgroundColor = [UIColor clearColor];
    [_gameBoardUI setDataSource:self];
    [_gameBoardUI setDelegate:self];
    [self addSubview:_gameBoardUI];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showGrid
{
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height*(GOLDEN_RATIO));
    
    _grid =[[GridLines alloc]initWithFrame:CGRectMake(0, 0,(int) GAME_SIZE,(int) GAME_SIZE)];
    _grid.backgroundColor = [UIColor clearColor];
    _grid.center = center;
    [self addSubview:_grid];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    double const numOfCell = 9;
    return numOfCell;
}
-(void)getBoard
{
    if (!_boardArray) {
        _boardArray = [NSMutableArray array];
    }
    _boardArray = [_dataSource getBoard:self];
}

-(void)updateBoardUI
{
    NSMutableArray *indexPathArr = [NSMutableArray array];
    [self getBoard];
    for (int i=0; i<9; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [indexPathArr addObject:indexPath];
    }

    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [_gameBoardUI reloadItemsAtIndexPaths:indexPathArr];

    } completion:^(BOOL finished) {
        
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (GameCellUI *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameCellUI *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    
    [cell removeLabel];
    
    if ([_boardArray[indexPath.row] integerValue] == -1)
    {
        [cell addLabel];
        [cell colorPink];
        [cell setLabelCenter:CGPointMake((GAME_SIZE)/6,(GAME_SIZE)/6)];

        
    }else if ([_boardArray[indexPath.row] integerValue]==1)
    {
        [cell addLabel];
        [cell colorWhite];
        [cell setLabelCenter:CGPointMake((GAME_SIZE)/6,(GAME_SIZE)/6)];

        

    }
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((GAME_SIZE)/3,(GAME_SIZE)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
//    GameCellUI * cell = (GameCellUI*) [collectionView cellForItemAtIndexPath:indexPath];
    
    [self cellPressedDelegateWithCellNUmber:indexPath.row];

    if (_boardArray[indexPath.row] != 0) {

        NSArray *indexPathArr = [NSArray arrayWithObjects:indexPath, nil];
        [_gameBoardUI reloadItemsAtIndexPaths:indexPathArr];
    }

   // [self updateBoardUI];
    
}
-(void)cellPressedDelegateWithCellNUmber:(NSInteger)num
{
    [_delegate cellPress:self withCellNumber:num];
}

-(void)finishAnimation
{
    [_delegate animationDidFinishLoad];
}

-(void)endGameAnimationUp
{
    [UIView animateWithDuration:0.52 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        _grid.transform =CGAffineTransformMakeTranslation(0, -24);
        _gameBoardUI.transform =CGAffineTransformMakeTranslation(0, -24);

    } completion:^(BOOL finished) {
        
    }];
}
-(void)newGameAnimationDown
{
    [UIView animateWithDuration:0.52 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        _grid.transform =CGAffineTransformMakeTranslation(0, 0);
        _gameBoardUI.transform =CGAffineTransformMakeTranslation(0, 0);

    } completion:^(BOOL finished) {
    }];
}

-(void)fadeInAnimation
{
    _grid.transform = CGAffineTransformMakeScale(0.7, 0.7);
    _grid.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _grid.transform = CGAffineTransformMakeScale(1, 1);
        _grid.alpha = 1;
        
    } completion:^(BOOL finished) {
        [self finishAnimation];

    }];
    
}

-(void)updateBoard:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    NSArray *indexPathArr = [NSArray arrayWithObjects:indexPath, nil];
    [_gameBoardUI reloadItemsAtIndexPaths:indexPathArr];
}


@end
