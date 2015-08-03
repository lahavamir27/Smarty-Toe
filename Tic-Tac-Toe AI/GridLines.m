//
//  Grid.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 20/06/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "GridLines.h"
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define GREY_COLOR   Rgb2UIColor(127,160,189,.5)

@interface GridLines()

@property (nonatomic) NSInteger gridSize;

@end


@implementation GridLines





- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, GREY_COLOR.CGColor);
    
    
    // calculate column width
    CGFloat columnWidth = self.frame.size.width / (3);
    
    for(int i = 1; i <= 2; i++)
    {
        CGPoint startPoint;
        CGPoint endPoint;
        
        startPoint.x = columnWidth * i;
        startPoint.y = 0.0f;
        
        endPoint.x = startPoint.x;
        endPoint.y = self.frame.size.height;
        
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }
    
    
    // calclulate row height
    CGFloat rowHeight = self.frame.size.height / (3);
    
    for(int j = 1; j <= 2; j++)
    {
        CGPoint startPoint;
        CGPoint endPoint;
        
        startPoint.x = 0.0f;
        startPoint.y = rowHeight * j;
        
        endPoint.x = self.frame.size.width;
        endPoint.y = startPoint.y;
        
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }
}

@end
