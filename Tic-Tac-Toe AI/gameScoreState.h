//
//  LevelState.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 04/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameScoreState : NSObject


-(id)init;

-(void)addWin;
-(void)addLost;
-(void)addDraw;
-(void)printState;
-(void)resetState;

-(NSInteger)getWin;
-(NSInteger)getLost;
-(NSInteger)getDraw;



@end
