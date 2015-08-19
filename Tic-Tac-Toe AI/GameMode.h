//
//  GameMode.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 15/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GameMode : NSObject

enum{
    xHumanOComputer = 0,
    xHumanOHuman = 1,
    xComputerOhuman = 2,
};
typedef NSUInteger TTTGameMode;


+(NSString*)convertGameModeToString:(TTTGameMode)gameMode;

@end
