//
//  PlayerType.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 24/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    boardMarkO = -1,
    boardMarkEmpty = 0,
    boardMarkX = 1,
};
typedef NSUInteger TTTPlayerType;

@interface PlayerType : NSObject

@end
