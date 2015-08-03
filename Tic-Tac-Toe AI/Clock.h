//
//  Clock.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 27/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Clock;

@protocol ClockDelegate <NSObject>

-(void)clockDidFinish;

@end

@interface Clock : UIView

@property (nonatomic,weak) id <ClockDelegate>delegate;

-(void)fireCountDown;
-(void)resetTimer;


@end
