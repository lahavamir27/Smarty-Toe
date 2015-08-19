//
//  OnboardViewController.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 05/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "ScrollViewController.h"
#define WINDOW_SIZE_WIDTH  self.view.frame.size.width
#define WINDOW_SIZE_HEIGHT  self.view.frame.size.height
#define GOLDEN_RATIO 0.50
#define GAME_SIZE  self.view.frame.size.width*.70
#define BACKGROUND_COLOR   Rgb2UIColor(57, 79, 98, 1)
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface ScrollViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) GridLines * grid;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupUI];
}

-(void)setupUI
{
    [self initScrollview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScrollview
{
    NSLog(@"scroll");
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc ]initWithFrame:CGRectMake(0, 0, WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT-60)];
//        _scrollView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_scrollView];
        _scrollView.scrollEnabled = NO;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
