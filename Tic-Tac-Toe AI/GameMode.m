//
//  GameMode.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 15/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameMode.h"

@implementation GameMode




+(NSString*)convertGameModeToString:(TTTGameMode)gameMode
{
    NSString *str;
    
    switch (gameMode) {
        case 0:
            str = @"X:Human O:Computer";
            break;
        case 1:
            str = @"X:Human O:Human";
            break;
        case 2:
            str = @"X:Computer O:Human";

            break;
    }
    
    return str;
}

@end
