//
//  Board.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 13/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "Board.h"



@interface Board()

@property (nonatomic,strong)NSMutableArray *grid;

@end


@implementation Board



-(instancetype)init
{
    self = [super init];
    if (self) {
        [self resetBoard];
    }
    return self;
}

-(NSMutableArray*)getGrid
{
    return _grid;
}

-(void)resetBoard
{
    if (!_grid) {
        _grid = [NSMutableArray array];
    }
    for (int i = 0 ; i<9; i++) {
        _grid[i] = @0;
    }
}

-(void)placeMove:(TTTPlayerType)player atIndex:(NSInteger)index
{
    if ([self isValidMoves:index]) {
        NSNumber *marker = [NSNumber numberWithLong:player];
        [_grid replaceObjectAtIndex:index withObject:marker];
    }
}

-(NSMutableArray*)legalMoves
{
    NSMutableArray *legalMoves = [NSMutableArray array];
    for (int i = 0; i<_grid.count; i++) {
        NSInteger mark = [_grid[i] integerValue];
        if (mark==0) {
            NSNumber *index = [NSNumber numberWithInt:i];
            [legalMoves addObject:index];
        }
    }
    return legalMoves;
}

-(BOOL)isValidMoves:(NSInteger)index
{
    if (index>8||index<0)
    {
        return NO;
    }
    
    NSUInteger move = [_grid[index] integerValue];
    
    if (move == 0)
    {
        return YES;
    }
    return NO;
    
}

- (void) undoMoveAtLocation:(NSInteger)index {
    if (index < 0 || index > 8) {
        return;
    }
    
    [self.grid replaceObjectAtIndex:index withObject:@0];
}

-(TTTPlayerType)winner
{
    long leftDiagonal = [self scoreForDiagonal:0];
    long rightDiagonal = [self scoreForDiagonal:2];
   
    
    // diagonal winer
    if (rightDiagonal == 3 || leftDiagonal == 3) {
        return  boardMark0;
    }
    if (rightDiagonal == -3 || leftDiagonal == -3) {
        return  boardMarkX;
    }
    
    for (int i = 0; i < 3 ; i++) {
        long rowScore = [self scoreForRow:i];
        long columnScore = [self scoreForColumn:i];
        
        if (rowScore == 3 || columnScore == 3) {
            return boardMark0;
        }
        if (rowScore == -3 || columnScore == -3) {
            return boardMarkX;
        }
    
    }

    return boardMarkEmpty;
}

-(BOOL)twoInARow
{
    long leftDiagonal = [self scoreForDiagonal:0];
    long rightDiagonal = [self scoreForDiagonal:2];
    
    
    // diagonal winer
    if (rightDiagonal == 2 || leftDiagonal == 2) {
        return  YES;
    }

    
    for (int i = 0; i < 3 ; i++) {
        long rowScore = [self scoreForRow:i];
        long columnScore = [self scoreForColumn:i];
        
        if (rowScore == 2 || columnScore == 2) {
            return YES;
        }

        
    }
    
    return NO;
}

-(BOOL)isGameComplete
{
    NSMutableArray *moves = [self legalMoves];
    NSInteger winner = [self winner];
    
    if (moves.count == 0 || winner != 0)
    {
        return YES;
    }
    
    return NO;
    
}

-(NSInteger)scoreForRow:(NSInteger)row
{
    if (row<0||row>2) {
        return 0;
    }
    long score = 0;
    long index = (int) row * 3;
    
    for (long i = index ; i < index + 3; i++) {
        long tempScore = [_grid[i]integerValue];
        score = score + tempScore;
    }
    return score;
}

-(NSInteger)scoreForColumn:(NSInteger)column
{
    if (column<0||column>2) {
        return 0;
    }
    long score = 0;
    
    for (long i = column; i < _grid.count; i=i+3) {
        long tempScore = [_grid[i]integerValue];
        score = score + tempScore;
    }
    

    return  score;
}

-(NSInteger)scoreForDiagonal:(NSInteger)topCorner
{

    if (topCorner != 0 && topCorner !=2)
    {
        return 0;
    }
    
    long score = 0;
    if (topCorner == 0) {
        for (int i = 0 ; i<_grid.count; i= i+4)
        {
            long tempScore = [_grid[i]integerValue];
            score = score + tempScore;

        }
    }else if (topCorner == 2)
    {
        for (int i = 2 ; i<7; i= i+2) {
            long tempScore = [_grid[i]integerValue];
            score = score + tempScore;
        }
    }
   
    return score;
    
}
@end
