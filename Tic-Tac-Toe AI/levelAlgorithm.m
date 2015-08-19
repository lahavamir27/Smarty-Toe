//
//  Level.m
//  Tic-Tac-Toe AI
//
//  Created by amir on 25/07/15.
//

#import "levelAlgorithm.h"

@implementation levelAlgorithm


+(NSInteger)getLevelWithState:(gameScoreState*)state andLevel:(level)level
{
    if ([state getWin] >= 3 && level != impossible ) {
        return level + 1;
    }
    if ([state getLost] >=4 && level != easy) {
        return level - 1;
    }
    
    if ([state getDraw] >=8 && level != easy) {
        return level - 1;
    }
    
    if ([state getDraw]*0.25 +[state getLost]*0.5 >= 2 && level != easy) {
        return level - 1;
    }
    
    return  level;
}

-(NSString*)convertLevelToString:(level)level
{

    switch (level) {
        case 0:
            return @"easy";
            break;
            
        case 1:
            return @"medium";
            break;
            
        case 2:
            return @"hard";
            break;
            
        case 3:
            return @"impossible";
            break;
            
        default:
            break;
    }
    return @"";
}


@end
