//
//  Player.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"
#import "PlayerType.h"

enum {
    computer = 0,
    human = 1,
};
typedef NSUInteger TTTPlayerMode;




@interface Player : NSObject


-(instancetype)initWithOwner:(TTTPlayerMode)num;
-(NSInteger)getPlayerNumber;
-(NSInteger)getScroe;
-(NSString*)getPlayerName;
-(NSInteger)getPLayerLevel;

-(void)addWinning;


@end
