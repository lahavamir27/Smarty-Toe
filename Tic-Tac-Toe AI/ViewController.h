//
//  ViewController.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoardUI.h"
#import "Ai.h"
#import "ButtomScoreBoard.h"
#import "ButtomButton.h"
#import "NavigationBar.h"
#import "Clock.h"
#import "FirstViewController.h"


enum{
    xHumanOComputer = 0,
    xHumanOHuman = 1,
    xComputerOhuman = 2,
};
typedef NSUInteger TTTGameMode;

enum{
    xTurn = 0,
    oTurn = 1,
};
typedef NSUInteger TTTturn;

@interface ViewController : UIViewController

@property (nonatomic) TTTGameMode gameMode;


@end

