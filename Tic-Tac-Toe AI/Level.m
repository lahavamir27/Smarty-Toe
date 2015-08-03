//
//  Level.m
//  Tic-Tac-Toe AI
//
//  Created by amir on 25/07/15.
//

#import "Level.h"

@implementation Level


+(NSInteger)getLevelWithNumOfWins:(NSInteger)num andLevel:(level)level
{
    if (num>3 && level != hard) {
        return level + 1;
    }
    else if (num > 3 && level == hard)
    {
        return  imposible;
    }else
    {
        return  level;
    }

}



@end
