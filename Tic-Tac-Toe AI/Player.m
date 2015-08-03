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
@property (nonatomic) NSInteger playerLevel;
@property (nonatomic) NSInteger scroe;
@property (nonatomic) NSString *playerName;


@end

@implementation Player


-(instancetype)initWithOwner:(TTTPlayerMode)num
{
    self = [super init];
    if (self) {
        
        _playerNum = num;
        _scroe = 0;
        if (num == 0) {
            _playerLevel = 0;
        }
        [self setPlayerName];
        
    }
    return self;
}

-(void)setPlayerName
{
    if (_playerNum == computer) {
        _playerName = @"computer";
    }
    else
    {
        _playerName = @"humen";
    }
}

-(void)setPlayerLevel:(level)lvl
{
    if (lvl != human) {
        _playerLevel = lvl;
    }else
    {
        _playerLevel = human;
    }
}

-(NSInteger)getPlayerNumber
{
    return _playerNum;
}
-(NSInteger)getPLayerLevel
{
    return _playerLevel;
}
-(void)addWinning
{
    _scroe += 1;
}
-(NSInteger)getScroe
{
    return _scroe;
}
-(NSString*)getPlayerName
{
    return _playerName;
}

@end
