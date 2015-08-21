//
//  NavigationBar.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 26/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ExtendedColorScheme.h"
@class NavigationBar;


@protocol NavigationBarDelegate <NSObject>

-(void)backButtonPressed;

@end
@interface NavigationBar : UIView

@property (nonatomic,weak) id <NavigationBarDelegate>delegate;


-(void)setLevelTitleWithLevel:(NSInteger)lvl;
-(void)addAlert:(NSString*)str;
-(void)removeAlertLabel;
-(void)setMainTitleText:(NSString*)str;
-(void)fadeInAnimation;
-(void)fadeoutAnimation;
-(void)fadeoutAnimationWithDepth:(NSInteger)depth;

@end
