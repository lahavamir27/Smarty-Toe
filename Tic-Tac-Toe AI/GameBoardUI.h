//
//  GameBoardUI.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCellUI.h"
#import "Board.h"

@class GameBoardUI ;

@protocol GameBoardUIDataSource <NSObject>

-(NSMutableArray*)getBoard:(GameBoardUI*)board;

@end

@protocol GameBoardUIDelegate <NSObject>

-(void)cellPress:(GameBoardUI*)cell withCellNumber:(NSInteger)num;

@end

@interface GameBoardUI : UIView

@property (weak, nonatomic) id<GameBoardUIDataSource>dataSource;
@property (nonatomic,weak) id <GameBoardUIDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame andDataSource:(id<GameBoardUIDataSource>)dataSource;

-(void)updateBoardUI;

@end
