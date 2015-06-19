//
//  AI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 14/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "AI.h"


@interface AI()


@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger bestMoveIndex;
@property (nonatomic) Board* currentBoard;

@end


@implementation AI



-(NSInteger)bestMove:(TTTLevel)level currentBoard:(Board*)board
{
    if (!_currentBoard) {
        _currentBoard = [[Board alloc]init];
    }
    _currentBoard = board;
    
    switch (level) {
        case 0:
            return [self levelEasyBestMove];
            break;
        case 1:
            return [self levelMediumBestMove];
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)levelEasyBestMove
{
    NSInteger bestMove;
    NSMutableArray *legelMoves = [_currentBoard legalMoves];
    if (legelMoves.count == 0) {
        return -1;
    }
    int count = (int) legelMoves.count;
    int index = arc4random_uniform(count);
    bestMove = [legelMoves[index] integerValue];
    return bestMove;
}

-(NSInteger)levelMediumBestMove
{
    NSInteger bestMove;
    
    NSMutableArray *legelMoves = [_currentBoard legalMoves];

    if (legelMoves.count == 0) {
        return -1;
    }
    
    for (int i = 0; i<legelMoves.count; i++) {
        if ([legelMoves[i]integerValue] == 4)
        {
            return 4;
        }

        
    }
    
    NSLog(@"%d",(int)[_currentBoard twoInARow]);
    for (int i = 0; i<legelMoves.count; i++)
       {
            if ([legelMoves[i]integerValue] == 0)
            {
                return 0;
            }
       }
        
        
    
    int count = (int) legelMoves.count;
    int index = arc4random_uniform(count);
    bestMove = [legelMoves[index] integerValue];
    
    return bestMove;

}

@end
