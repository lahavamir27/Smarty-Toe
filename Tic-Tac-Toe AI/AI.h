//
//  AI.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 14/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
enum {
    easy = 0,
    medium = 1,
    hard = 2,
};
typedef NSUInteger TTTLevel;


@interface AI : NSObject

-(NSInteger)bestMove:(TTTLevel)level currentBoard:(Board*)board;



@end
