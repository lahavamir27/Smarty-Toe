//
//  Player.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    computer = 1,
    human = 2,
};
typedef NSUInteger TTTPlayerMode;

@interface Player : NSObject


-(instancetype)initWithOwner:(TTTPlayerMode)num;
-(NSInteger)getPlayerNumber;


@end
