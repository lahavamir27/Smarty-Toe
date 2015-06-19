//
//  Board.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 13/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    boardMarkX = -1,
    boardMarkEmpty = 0,
    boardMark0 = 1,
};
typedef NSUInteger TTTPlayerType;

@interface Board : NSObject



-(instancetype)init;
-(BOOL)twoInARow;
-(void)resetBoard;
-(NSMutableArray*)legalMoves;
-(void)placeMove:(TTTPlayerType)player atIndex:(NSInteger)index;
-(TTTPlayerType)winner;
-(NSMutableArray*)getGrid;
-(BOOL)isGameComplete;

@end
