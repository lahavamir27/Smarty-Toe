//
//  Player.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "Player.h"



@interface Player()

@property (nonatomic) NSInteger playerNum;

@end

@implementation Player


-(instancetype)initWithOwner:(TTTPlayerMode)num
{
    self = [super init];
    if (self) {
        
        _playerNum = num;
        
    }
    return self;
}


-(NSInteger)getPlayerNumber
{
    return _playerNum;
}

@end
