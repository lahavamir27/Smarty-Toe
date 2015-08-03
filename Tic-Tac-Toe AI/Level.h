//
//  Level.h
//  Tic-Tac-Toe AI
//
//  Created by amir on 25/07/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    humen = -1,
    easy = 0,
    meduim = 1,
    hard = 2,
    imposible = 3,
};
typedef NSInteger level;



@interface Level : NSObject


+(NSInteger)getLevelWithNumOfWins:(NSInteger)num andLevel:(level)level;

@end
