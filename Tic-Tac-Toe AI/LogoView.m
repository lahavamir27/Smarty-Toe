//
//  LogoView.m
//  Tic-Tac-Toe AI
//
//  Created by amir on 27/07/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "LogoView.h"

#define LOGO_SIZE  self.frame.size.width
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface LogoView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation LogoView



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0.1;
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:_collectionView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];


    UILabel *lbl = [[UILabel alloc ]initWithFrame: cell.bounds];
    
    long const windowWidth = 320;
    
    lbl.layer.borderWidth = 8 * self.window.frame.size.width/windowWidth;
    
    if (indexPath.row%2 == 0) {
        lbl.layer.borderColor = Rgb2UIColor(95, 200, 235, 1).CGColor;
    }else
    {
        lbl.layer.borderColor = Rgb2UIColor(240, 166, 220, 1).CGColor;
        lbl.layer.cornerRadius = lbl.frame.size.width/2;
    }
    
    [cell addSubview:lbl];
    
    lbl.transform = CGAffineTransformMakeScale(0.1, 0.1);
    lbl.alpha = 0;
    [UIView animateWithDuration:0.5 delay:indexPath.row*0.04 options:0 animations:^{
        
        lbl.transform = CGAffineTransformMakeScale(0.78, 0.78);
        lbl.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(LOGO_SIZE/4-1, LOGO_SIZE/4-1);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
