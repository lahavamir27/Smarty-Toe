//
//  ButtomScoreBoard.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 19/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "UIColor+ExtendedColorScheme.h"

@interface ButtomScoreBoard : UIView

-(void)setScoreForPlayerX:(NSInteger)score;
-(void)setScoreForPlayerO:(NSInteger)score;

-(void)renamePlayerNames:(NSString*)playerX andPlayerO:(NSString*)playerO;

-(void)fadeInAnimation;
-(void)endGameAnimationUp;
-(void)newGameAnimationDown;
-(void)endGameAnimationDownWithDepth:(NSInteger)depth;


@end
