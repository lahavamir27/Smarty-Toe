//
//  GameBoardUI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameBoardUI.h"
#define GOLDEN_RATIO 0.52
#define WIDTH_RATIO 0.9
@interface GameBoardUI() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *gameBoardUI;
@property (nonatomic,strong) NSMutableArray * boardArray;

@end

@implementation GameBoardUI


-(instancetype)initWithFrame:(CGRect)frame andDataSource:(id<GameBoardUIDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createGameBoardUI];
        if (dataSource) _dataSource = dataSource;
    }
    
    return  self;
}


-(void)createGameBoardUI
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _gameBoardUI=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * WIDTH_RATIO, self.frame.size.width * WIDTH_RATIO) collectionViewLayout:layout];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1.5;
    
    [_gameBoardUI setDataSource:self];
    [_gameBoardUI setDelegate:self];
    
    _gameBoardUI.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*(1-GOLDEN_RATIO));
    [_gameBoardUI registerClass:[GameCellUI class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_gameBoardUI setBackgroundColor:[UIColor blackColor]];
    
    [self addSubview:_gameBoardUI];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
-(void)getBoard
{
    _boardArray = [_dataSource getBoard:self];
}

-(void)updateBoardUI
{
    [self getBoard];
    [_gameBoardUI reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSString*)convertToString:(NSInteger)index;
{
    NSString *str = [[NSString alloc]init];
    
    if (!_boardArray[index]||[_boardArray[index] isEqual:@0])
    {
       return  @"";
    }
    else if ([_boardArray[index]integerValue] == 1)
    {
        return   @"X";
    }
    else
    {
        return   @"O";
    }
    return str;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (GameCellUI *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameCellUI *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    [cell setLabelTitle:[self convertToString:indexPath.row]];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.frame.size.width*WIDTH_RATIO-3)/3,(self.frame.size.width * WIDTH_RATIO-3)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
//    GameCellUI * cell = (GameCellUI*) [collectionView cellForItemAtIndexPath:indexPath];

    [self cellPressedDelegateWithCellNUmber:indexPath.row];
    [self updateBoardUI];

    
}
-(void)cellPressedDelegateWithCellNUmber:(NSInteger)num
{
    [_delegate cellPress:self withCellNumber:num];
}


@end
