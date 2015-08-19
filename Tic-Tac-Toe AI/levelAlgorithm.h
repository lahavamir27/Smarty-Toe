//
//  Level.h
//  Tic-Tac-Toe AI
//
//  Created by amir on 25/07/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gameScoreState.h"

enum {
    humen = -1,
    easy = 0,
    meduim = 1,
    hard = 2,
    impossible = 3,
};
typedef NSInteger level;



@interface levelAlgorithm : NSObject


+(level)getLevelWithState:(gameScoreState*)state andLevel:(level)level;
-(NSString*)convertLevelToString:(level)level;

@end
