//
//  ButtomButton.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ExtendedColorScheme.h"
@class BottomButton ;


@protocol ButtomButtonDelegate <NSObject>

-(void)buttonPress:(BottomButton*)button;

@end

@interface BottomButton : UIView

@property (nonatomic,weak) id <ButtomButtonDelegate>delegate;

-(void)setTitle:(NSString*)str;
-(void)endGameAnimationUpWithDepth:(NSInteger)depth;
-(void)newGameAnimationDown;

-(void)fixButtonSize;
-(void)setButtomButtonColor:(UIColor*)color withAnimation:(BOOL)animation;
-(void)addDivider;

@end




