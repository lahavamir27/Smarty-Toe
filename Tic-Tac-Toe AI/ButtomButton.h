//
//  ButtomButton.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtomButton ;


@protocol ButtomButtonDelegate <NSObject>

-(void)buttonPress:(ButtomButton*)button;

@end

@interface ButtomButton : UIView

@property (nonatomic,weak) id <ButtomButtonDelegate>delegate;

-(void)setTitle:(NSString*)str;
-(void)endGameAnimationUpWithDepth:(NSInteger)depth;
-(void)newGameAnimationDown;
-(void)disableButton;
-(void)enableButton;
-(void)fixButtonSize;
@end




