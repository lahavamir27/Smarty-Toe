//
//  GameCellUI.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 12/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GameCellUI.h"

@interface GameCellUI()

@property (nonatomic,strong) UILabel *lbl;

@end


@implementation GameCellUI

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
        [self addSubview:_lbl];
        
        
        
    }
    return self;
}

-(void)setLabelTitle:(NSString*)str
{
    _lbl.text = str;
}
-(NSString*)getLableTitle
{
    return  _lbl.text;
}

@end
