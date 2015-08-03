//
//  AI.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 14/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"



@interface AI : NSObject

- (NSInteger)bestMove:(TTTPlayerType)player currentBoard:(Board *)board andLevel:(level)level;



@end
