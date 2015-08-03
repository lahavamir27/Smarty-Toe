//
//  Board.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 13/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"


@interface Board : NSObject
@property (nonatomic,strong)NSMutableArray *grid;


- (instancetype)init;

- (void)undoMoveAtLocation:(NSInteger)index;
- (void)resetBoard;

-(NSMutableArray*)legalMoves;
-(BOOL)isGameComplete;
-(TTTPlayerType)winner;
-(NSMutableArray*)getGrid;
-(NSInteger)getOpponent:(TTTPlayerType)player;
-(void)clearBoard;

-(void)placeMove:(TTTPlayerType)player atIndex:(NSInteger)index;
-(BOOL)isEmpty:(Board*)board;

@end
