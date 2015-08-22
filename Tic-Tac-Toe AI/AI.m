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


-(BOOL)bestMove:(level)level
{
    double randomNumber = drand48();
    switch (level) {
        case easy:
            if (randomNumber<.75) {
                return YES;
            }
            return NO;
            break;
        case meduim:
            if (randomNumber<.85) {
                return YES;
            }
            return NO;
            break;
            
        case hard:
            if (randomNumber<.95) {
                return YES;
            }
            return NO;
            break;
            
        default:
            return YES;
            break;
    }
}

- (NSInteger)bestMove:(TTTPlayerType)player currentBoard:(Board *)board andLevel:(level)level
{
    
    // if the board is empty return random index
    if ([board isEmpty:board])
    {
        return arc4random_uniform(8);
    }
    
    _currentBoard = board;
    
    BOOL bestMove = [self bestMove:level];
    if (bestMove)
    {
        // else get the best move you can
        NSInteger move = [self negamaxForMarker:player withBoard:board depth:1 alpha:-10000 beta:10000];
        return move;
    }else
    {
        return [self getRandomMove];
    }

}

-(NSInteger)getRandomMove
{
    
    if ([_currentBoard isGameComplete]) {
        return -1;
    }
    NSMutableArray *legalMoves = [_currentBoard legalMoves];
    long count = legalMoves.count-1;
    NSInteger index = arc4random_uniform((unsigned int)count);

    return [legalMoves[index] integerValue];
}

#pragma mark - AI Methods

//
// Calculates the best move using the Negamax algorith enhanced with alpha-beta pruning, recursively.
//
- (NSInteger) negamaxForMarker:(TTTPlayerType)player withBoard:(Board*)board depth:(NSInteger)depth alpha:(NSInteger)alpha beta:(NSInteger)beta
{
    NSInteger bestMove = 0;
    NSInteger bestAlpha = -10000;
    
    
    TTTPlayerType opponent = [board getOpponent:player];
    
    if ([board isGameComplete])
    {
        return [self scoreBoard:board forPlayer:player];
    }
    
    // get all node suns
    
   NSMutableArray *legalMoves = [board legalMoves];
    
    // Loop through the available moves and recursively run negamax to find the move with the best score i.e. alpha
    for (int i = 0; i < [legalMoves count]; i++)
    {
        
        NSInteger move = [legalMoves[i] integerValue];
        
        // evaluate board for next state
        [board placeMove:player atIndex:move];
        
        // call recursively
        NSInteger score = -[self negamaxForMarker:opponent withBoard:board depth:depth + 1 alpha:-beta beta:-alpha];
        
        // get board to first state
        [board undoMoveAtLocation:move];
        
        // Found better score, update alpha
        if (score > alpha) {
            alpha = score;
        }
        
        // Prune the branch since the branch is not favorable to the player
        if (alpha >= beta) {
            break;
        }
        
        // Save the best seen move and alpha if we're at the original root node
        if (depth == 1 && alpha > bestAlpha) {
            bestAlpha = alpha;
            bestMove = move;
        }
    }
    
    // Return the move if we're at the root node, otherwise we want to return the alpha for the recursive call
    if (depth == 1) {
        return bestMove;
    } else {
        return alpha;
    }
}


#pragma mark - Evalute state


- (NSInteger) scoreBoard:(Board*)board forPlayer:(TTTPlayerType)player
{
    TTTPlayerType winner = [board winner];
    TTTPlayerType opponent = [board getOpponent:player];
    
    // Winning outcome for the player, score highly
    if (winner == player) {
        return 1;
    }
    
    // Losing outcome for the player, score poorly
    if (winner == opponent) {
        return -1;
    }
    
    // Otherwise, game have a draw
    return 0;
}

@end
