//
//  LevelState.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 04/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "gameScoreState.h"

@interface gameScoreState()

@property (nonatomic,readonly) NSInteger wins;
@property (nonatomic,readonly) NSInteger lost;
@property (nonatomic,readonly) NSInteger draw;

@end

@implementation gameScoreState


-(id)init
{
    self = [super init];
    if (self) {
        _wins = 0;
        _lost = 0;
        _draw = 0;
        
    }
    return self;
}


-(void)addWin
{
    _wins ++;
}
-(void)addLost
{
    _lost ++;
}
-(void)addDraw
{
    _draw ++;
}
-(NSInteger)getWin
{
   return  _wins;
}
-(NSInteger)getLost
{
   return  _lost;
}
-(NSInteger)getDraw
{
  return _draw;
}




-(void)printState
{
    NSLog(@"wins: %ld lost: %ld draw: %ld",(long)_wins,(long)_lost,(long)_draw);
}

-(void)resetState
{
    _wins = 0;
    _lost = 0;
    _draw = 0;
}

@end
