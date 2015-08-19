//
//  GameCellUI.h
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ExtendedColorScheme.h"
@interface GameCellUI : UICollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setLabelTitle:(NSString*)str;
-(NSString*)getLableTitle;
-(void)setLabelCenter:(CGPoint)center;
-(void)colorPink;
-(void)setSqureColorBlue;
-(void)addLabel;
-(void)removeLabel;

@end
