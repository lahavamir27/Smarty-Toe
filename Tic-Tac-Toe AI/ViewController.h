//
//  ViewController.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCellUI.h"
#import "GameBoardUI.h"
#import "Player.h"
#import "Board.h"
#import "Ai.h"

enum{
    singlePlyer = 0,
    twoPlayer = 1,
};
typedef NSUInteger TTTGameMode;

@interface ViewController : UIViewController


@end

