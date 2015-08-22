//
//  OnboardViewController.m
//  Tic-Tac-Toe AI
//
//  Created by amir lahav on 05/08/15.
//  Copyright (c) 2015 amir lahav. All rights reserved.
//

#import "OnboardViewController.h"
#define WINDOW_SIZE_WIDTH  self.view.frame.size.width
#define WINDOW_SIZE_HEIGHT  self.view.frame.size.height
#define GOLDEN_RATIO 0.50
#define GAME_SIZE  self.view.frame.size.width*.65
#define BACKGROUND_COLOR   Rgb2UIColor(57, 79, 98, 1)
#define Rgb2UIColor(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define FONT_LIGHT(a) [UIFont fontWithName:@"Avenir-Light" size:(a)]
#define FONT(a) [UIFont fontWithName:@"Avenir-Book" size:(a)]

#define IPHONE_4_HEIGHT 480
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define kMaxImageSize 1.3
#define kMaxGameSize 320

@interface OnboardViewController () <ButtomButtonDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) GridLines * grid;
@property (nonatomic,strong) UIImageView * disclosureImageView;
@property (nonatomic,strong) NSTimer * blinkTimer;
@property (nonatomic,strong) UIButton * playButton;

@property (nonatomic) BOOL player1human;

@property (nonatomic,strong) UILabel * smartyTitleLabel;
@property (nonatomic,strong) UILabel * smartySubTitleLabel;
@property (nonatomic,strong) UILabel * AITitleLabel;
@property (nonatomic,strong) UILabel * AISubTitleLabel;
@property (nonatomic,strong) UILabel * MultiPlayerTitle;
@property (nonatomic,strong) UILabel * MultiPlayerSubTitle;

@property (nonatomic,strong) UILabel * threeInARowSquare;

@property (nonatomic,strong) NSMutableArray * markerArray;
@property (nonatomic,strong) ButtomButton * startGameButton;
@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIView * welcomeContainerView;
@property (nonatomic,strong) UIView * AIContainerView;
@property (nonatomic,strong) UIView * multiplayerContainerView;

@property (nonatomic,strong) UIImageView * AIImageView;
@property (nonatomic,strong) UIImageView * multyPlayerImageView;

@property (strong, nonatomic) SMPageControl *pageControl;
@property (strong, nonatomic) NSNumber *watch;

@property BOOL isPlay;
@property BOOL finishScroll;
@property BOOL watchIntro;


@property double gameSize;
@property double currentPage;
@property NSInteger scollOffest;



@end

@implementation OnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgrounDarkBlue];
    [self initScorllView];
    [self initScrollViewContainers];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    _watch = [defaults objectForKey:@"watch"];
    
    

    
    _watchIntro = YES;
    
    [defaults setObject:[NSNumber numberWithBool:_watchIntro] forKey:@"watch"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([_watch integerValue] == 1) {
        [self performSegueWithIdentifier:@"main" sender:nil];
    }
    [self setupUI];
}

-(void)setupUI
{
    [self initGrid];
    [self initImageView];
    [self initWelcomeTitle];
    [self initWelcomeSubTitle];

}

#pragma mark - Init Main Views


-(void)initScorllView
{
    double const contentWidth = WINDOW_SIZE_WIDTH*3;
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(contentWidth, WINDOW_SIZE_HEIGHT);
        _scrollView.hidden = NO;
        _scrollView.scrollEnabled = NO;
        
    }
}
-(void)initScrollViewContainers
{
    if (!_welcomeContainerView) {
        _welcomeContainerView = [[UIView alloc]initWithFrame:self.view.bounds];
        [_scrollView addSubview:_welcomeContainerView];
    }
    if (!_AIContainerView) {
        _AIContainerView = [[UIView alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH, 0, WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT)];
//        _AIContainerView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_AIContainerView];
        [self initAiImageView];
        [self initAISubTitle];
    }
    if (!_multiplayerContainerView) {
        _multiplayerContainerView = [[UIView alloc]initWithFrame:CGRectMake(WINDOW_SIZE_WIDTH*2, 0, WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT)];
        [_scrollView addSubview:_multiplayerContainerView];
        [self initMultiplayerTitle];
        [self initMultyplayerImageView];
        [self initMultyplayerSubTitle];

    }
}


-(void)initGrid
{
    double const offset = -400;
    CGPoint center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*(GOLDEN_RATIO));
    _gameSize = GAME_SIZE;
    if (GAME_SIZE>kMaxGameSize) {
        _gameSize = kMaxGameSize;
    }
    
    _grid =[[GridLines alloc]initWithFrame:CGRectMake(0, 0,(int) _gameSize,(int) _gameSize)];
    _grid.backgroundColor = [UIColor clearColor];
    _grid.center = center;
    [self.view addSubview:_grid];
    _grid.alpha = 0;
    [self addMarkers];
    
    _grid.transform = CGAffineTransformMakeTranslation(0, offset);
    [UIView animateWithDuration:.8 delay:0.5 usingSpringWithDamping:.6 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _grid.alpha = 1;

        _grid.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.7 animations:^{


    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:1 delay:.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
    } completion:^(BOOL finished) {
        
    }];
}



-(void)initButtomButton
{
    double const depth = 60;
    if (!_startGameButton) {
        _startGameButton = [[ButtomButton alloc ]initWithFrame:CGRectMake(0, WINDOW_SIZE_HEIGHT, WINDOW_SIZE_WIDTH, 60)];
    }
    _startGameButton.delegate = self;
    [self.view addSubview:_startGameButton];
    [_startGameButton endGameAnimationUpWithDepth:depth];
    [_startGameButton setButtomButtonColor:BACKGROUND_COLOR withAnimation:NO];
    [_startGameButton setTitle:@"NEXT"];
    [_startGameButton addDivider];
}


-(void)createPageControl
{
    
    int numOfPages,currentPage,indicatorDiameter,alpha, indicatorMargin;
    numOfPages = 3;
    currentPage = 0;
    indicatorDiameter = 8;
    indicatorMargin = 10;

    alpha = 0;
    
    CGRect framePageControl = CGRectMake(80,0,160,20);
    
    if (!self.pageControl)
    {
        self.pageControl = [[SMPageControl alloc] initWithFrame:framePageControl] ;
    }
    _pageControl.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT-85);
    self.pageControl.numberOfPages = numOfPages;;
    self.pageControl.currentPage = currentPage;
    self.pageControl.indicatorDiameter = indicatorDiameter;
    [self.pageControl setIndicatorMargin:indicatorMargin];
    self.pageControl.currentPageIndicatorTintColor = [UIColor lightPink];
    self.pageControl.alpha = alpha;
    self.pageControl.transform=CGAffineTransformMakeScale(.1, .1);
    self.pageControl.pageIndicatorTintColor = [UIColor dividerColorBlue];
    
    [self.view addSubview:self.pageControl];
    [UIView animateWithDuration:0.7
                          delay:0.7
         usingSpringWithDamping:0.5
          initialSpringVelocity:1
                        options:0
                     animations:^{
                         self.pageControl.transform=CGAffineTransformMakeScale(1, 1);
                         self.pageControl.alpha=1;
                     }
                     completion:^(BOOL finished)
     {
         
     } ];
    
    
    
}
#pragma mark - Init Markers


-(void)addMarkers
{
    
    
    double const width =  _grid.frame.size.width/6;
    double const height =  _grid.frame.size.height/6;
    
    UILabel *first = [self createCircle];
    first.center =CGPointMake(width*1, height);
    [self.grid addSubview:first];
    
    UILabel *second = [self createSquare];
    second.center =CGPointMake(width*3, height);
    [self.grid addSubview:second];
    
    UILabel *third = [self createCircle];
    third.center =CGPointMake(width*5, height);
    [self.grid addSubview:third];
    
    UILabel *forth = [self createSquare];
    forth.center =CGPointMake(width*1, height*3);
    [self.grid addSubview:forth];
    
    UILabel *fifth = [self createSquare];
    fifth.center =CGPointMake(width*3, height*3);
    [self.grid addSubview:fifth];
    
    UILabel *sixth = [self createCircle];
    sixth.center =CGPointMake(width*5, height*3);
    //    [self.grid addSubview:sixth];
    
    UILabel *seventh = [self createCircle];
    seventh.center =CGPointMake(width*1, height*5);
    [self.grid addSubview:seventh];
    
    UILabel *eighth = [self createCircle];
    eighth.center =CGPointMake(width*3, height*5);
    [self.grid addSubview:eighth];
    
    UILabel *ninth = [self createSquare];
    ninth.center =CGPointMake(width*5, height*5);
    [self.grid addSubview:ninth];
    
    [self initPlayButton];
    _playButton.center = CGPointMake(width*5, height*3);
    [self.grid addSubview:_playButton];
    
    _markerArray = [NSMutableArray arrayWithObjects:first,second,third,seventh,eighth,ninth, nil];
    
}


-(UILabel*)createSquare
{
    double const labelSize = _gameSize/5;
    UILabel *square = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelSize, labelSize)];
    square.center = _grid.center;
    square.layer.borderWidth = 8 ;
    square.layer.borderColor = [UIColor lightBlue].CGColor;
    
    return square;
}

-(UILabel*)createCircle
{
    double const labelSize = _gameSize/5;
    UILabel *circle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelSize, labelSize)];
    circle.center = _grid.center;
    
    circle.layer.borderColor = [UIColor lightPink].CGColor;
    circle.layer.borderWidth = 7;
    circle.layer.cornerRadius = circle.frame.size.width/2;
    return circle;
}

#pragma mark - Init images


-(void)initImageView
{
    double const distanceFromTopVIew = WINDOW_SIZE_HEIGHT*.49;
    double const imageSize = 16;
    if (!_disclosureImageView) {
        UIImage *image = [UIImage imageNamed:@"Previous"];
        _disclosureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_grid.frame.origin.x + _grid.frame.size.width+10, distanceFromTopVIew, imageSize, imageSize)];
        _disclosureImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _disclosureImageView.image = image;
        _disclosureImageView.alpha = 0;
        _disclosureImageView.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.view addSubview:_disclosureImageView];
        [self animateImageView];
        
    }
}



-(void)initAiImageView
{
    if (!_AIImageView) {
        UIImage *image = [UIImage imageNamed:@"smartyAI"];
        double const imageSize = 260;
        double imageSizeRatio = WINDOW_SIZE_WIDTH/390;
        if (imageSizeRatio>kMaxImageSize) {
            imageSizeRatio = kMaxImageSize;
        }
        _AIImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80,80, imageSize*imageSizeRatio, imageSize*imageSizeRatio)];
        _AIImageView.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*0.3);
        _AIImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _AIImageView.image = image;
        _AIImageView.alpha = 1;
        _AIImageView.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.AIContainerView addSubview:_AIImageView];
        
    }
}

-(void)initMultyplayerImageView
{
    if (!_multyPlayerImageView) {
        UIImage *image = [UIImage imageNamed:@"multiplayer"];
        double const imageSize = 260;
        double imageSizeRatio = WINDOW_SIZE_WIDTH/390;
        if (imageSizeRatio>kMaxImageSize) {
            imageSizeRatio = kMaxImageSize;
        }
        _multyPlayerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80,80, imageSize*imageSizeRatio, imageSize*imageSizeRatio)];
        _multyPlayerImageView.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*0.3);
        _multyPlayerImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _multyPlayerImageView.image = image;
        _multyPlayerImageView.alpha = 1;
        _multyPlayerImageView.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.multiplayerContainerView addSubview:_multyPlayerImageView];
        
    }
}

#pragma mark - init Titles


-(UILabel*)addMainTitle
{
    double const height = 35;
    double const width = 320;
    double ratio = 0.63;
    double titlesDistanceFromTopView = WINDOW_SIZE_HEIGHT * ratio;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        title.font = FONT_LIGHT(32);
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.center = CGPointMake(WINDOW_SIZE_WIDTH/2, titlesDistanceFromTopView);
        title.text = @"Welcome to Smarty";

    return title;
    
}


-(void)initWelcomeTitle
{
    if (!_smartyTitleLabel) {
        _smartyTitleLabel = [self addMainTitle];
        _smartyTitleLabel.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT+_smartyTitleLabel.frame.size.height/2);
        _smartyTitleLabel.alpha  = 0;
        [self.view addSubview:_smartyTitleLabel];
    }

}
-(void)initAITitle
{
    if (!_AITitleLabel) {
        _AITitleLabel = [self addMainTitle];
        _AITitleLabel.text = @"Fit for You";
        [_AIContainerView addSubview:_AITitleLabel];
        _AITitleLabel.alpha = 0;

    }
}

-(void)initMultiplayerTitle
{
    if (!_MultiPlayerTitle) {
        _MultiPlayerTitle = [self addMainTitle];
        _MultiPlayerTitle.text = @"Beat your Friends";
        [_multiplayerContainerView addSubview:_MultiPlayerTitle];
        _MultiPlayerTitle.alpha = 0;
    }
}


#pragma mark - init Sub Titles


-(UILabel*)addSubTitle
{
    double const height = 80;
    double const width = 300;
    
    UILabel * subTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];

        subTitle.font = FONT(13);
        subTitle.numberOfLines = 4;
        subTitle.textColor = Rgb2UIColor(176, 196, 212, 1);
     //   _subTitleLabel.textColor = [UIColor whiteColor];

        subTitle.textAlignment = NSTextAlignmentCenter;
        subTitle.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT+subTitle.frame.size.height/2);
    return subTitle;
    
}


-(void)initWelcomeSubTitle
{
    if (!_smartySubTitleLabel) {
        _smartySubTitleLabel = [self addSubTitle];
        _smartySubTitleLabel.text = @"Enjoy the world best Tic Tac Toe game ever Build. Smarty can bring something New to the game.";

        [self.view addSubview:_smartySubTitleLabel];
    }
    
}
-(void)initAISubTitle
{
    if (!_AISubTitleLabel) {
        _AISubTitleLabel = [self addSubTitle];
        [_AIContainerView addSubview:_AISubTitleLabel];
        _AISubTitleLabel.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*.63+55);
        _AISubTitleLabel.text = @"Smarty will adopt you. As much as you get better smarty will challange you!";
    }
    
}

-(void)initMultyplayerSubTitle
{
    if (!_MultiPlayerSubTitle) {
        _MultiPlayerSubTitle = [self addSubTitle];
        [_multiplayerContainerView addSubview:_MultiPlayerSubTitle];
        _MultiPlayerSubTitle.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*.63+55);
        _MultiPlayerSubTitle.text = @"With smarty you can enjoy a great family time. Smarty let you play with your closest ones.";
    }
}

-(void)initPlayButton
{
    double const playButtonSize = GAME_SIZE/3;
    if (!_playButton) {
        _playButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, playButtonSize, playButtonSize)];
//        _playButton.backgroundColor = [UIColor redColor];
        [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Action

-(void)playAction
{
    if (!_isPlay) {
        _isPlay = YES;
        [self addSquareWithAnimation];
        [self animateGridUp];
        [self animateTitleUp:_smartyTitleLabel];
        [self animateSubTitleUp];
        [self resetTimer];
        [self dimMarkersWithAnimation];
        [self performSelector:@selector(initButtomButton) withObject:nil afterDelay:0.2];
        [self createPageControl];
        
        [_welcomeContainerView addSubview:_grid];
        [_welcomeContainerView addSubview:_smartyTitleLabel];
        [_welcomeContainerView addSubview:_smartySubTitleLabel];
        [_AIContainerView addSubview:_AITitleLabel];
        
    }
}

-(void)timer
{
    _blinkTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(blinkImageViewAnimation) userInfo:nil repeats:YES];
}

-(void)resetTimer
{
    [_disclosureImageView removeFromSuperview];
    _disclosureImageView=nil;
    [_blinkTimer invalidate];
}



#pragma mark - Animation Up

-(void)animateGridUp
{
    double const ratio = WINDOW_SIZE_HEIGHT/IPHONE_4_HEIGHT;
    double const lift = 85;
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
    
        CGAffineTransform scaleTrans  = CGAffineTransformMakeScale(1, 1);
        CGAffineTransform lefttorightTrans  = CGAffineTransformMakeTranslation(0, - lift * ratio);
        _grid.transform = CGAffineTransformConcat(scaleTrans, lefttorightTrans);
    } completion:^(BOOL finished) {
    }];
}
-(void)animateTitleUp:(UILabel*)title
{

    [UIView animateWithDuration:0.7 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        title.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*.63);
        title.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
-(void)animateSubTitleUp
{
    double gap = 47;
    [UIView animateWithDuration:0.7 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        _smartySubTitleLabel.center = CGPointMake(WINDOW_SIZE_WIDTH/2, WINDOW_SIZE_HEIGHT*.63+gap);
    } completion:^(BOOL finished) {
        _scrollView.scrollEnabled = YES;
    }];
}

#pragma mark - Animation Down

-(void)animateImageDown
{
    
    
    [UIView animateWithDuration:0.3 delay:0.01 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
        _multyPlayerImageView.transform = CGAffineTransformMakeTranslation(-1000, 0);
        _multyPlayerImageView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
    [self performSelector:@selector(modalToMainViewController) withObject:nil afterDelay:0.5];

}

-(void)animateTitleDown
{
    
    [UIView animateWithDuration:0.3 delay:0.01 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionAllowUserInteraction animations:^{
        _MultiPlayerTitle.transform = CGAffineTransformMakeTranslation(-700, 0);
        _MultiPlayerTitle.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)animatePageControlDown
{
    
    [UIView animateWithDuration:0.3 delay:0.01 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _pageControl.transform = CGAffineTransformMakeTranslation(-50, 0);
        _pageControl.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)animateSubTitleDown
{
    [UIView animateWithDuration:0.3 delay:0.00 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _MultiPlayerSubTitle.transform = CGAffineTransformMakeTranslation(-550, 0);
        _MultiPlayerSubTitle.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - Small Animations

-(void)dimMarkersWithAnimation
{
    for (int i = 0; i<_markerArray.count; i++)
    {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_markerArray[i] setAlpha:0.05];
        } completion:^(BOOL finished) {
            
        }];
    }
}


-(void)animateImageView
{
      [self timer];
}

-(void)blinkImageViewAnimation
{
    [UIView animateWithDuration:.75 animations:^{
        _disclosureImageView.alpha = 0.6;
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:.75 animations:^{
             _disclosureImageView.alpha = 0.0;
         }];
     }];
    
}





-(void)fadeoutViewControllerAnimation
{
    [self animateImageDown];
    [self animateTitleDown];
    [self animatePageControlDown];
    [self animateSubTitleDown];
    [_startGameButton newGameAnimationDown];
}



-(void)addSquareWithAnimation
{
    
    double const width =  _grid.frame.size.width/6;
    double const height =  _grid.frame.size.width/6;
    
    _threeInARowSquare = [self createSquare];
    _threeInARowSquare.center =CGPointMake(width*5, height*3);
    [self.grid addSubview:_threeInARowSquare];
    _threeInARowSquare.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _threeInARowSquare.alpha = 0;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        _threeInARowSquare.transform = CGAffineTransformMakeScale(1, 1);
        _threeInARowSquare.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];

}






-(void)modalToMainViewController
{
    [self performSegueWithIdentifier:@"main" sender:nil];
}



#pragma mark - Delegate




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self updateOnboardState:_scrollView.contentOffset.x];


}

-(void)updateOnboardState:(CGFloat)offset
{
    double slowOffset = WINDOW_SIZE_WIDTH/1.5;
    double offsetX = WINDOW_SIZE_WIDTH/2-slowOffset;
    double offsetRatio = offset/WINDOW_SIZE_WIDTH;
    double subTitleGap = 47;
    double ratio = 0.63;
    double titlesDistanceFromTopView = WINDOW_SIZE_HEIGHT * ratio;

    
    _AIImageView.alpha = offsetRatio;
    [self initAITitle];
    
    if (offsetRatio<1.0001 && offsetRatio<2.0001) {
        
        _AITitleLabel.alpha = offsetRatio;
        _AITitleLabel.center = CGPointMake(WINDOW_SIZE_WIDTH - offset/2, titlesDistanceFromTopView) ;
        
        _AISubTitleLabel.center = CGPointMake(offset/1.5 + offsetX, titlesDistanceFromTopView + subTitleGap) ;
        _AISubTitleLabel.alpha = offsetRatio;

        _smartyTitleLabel.alpha = 1- offsetRatio;
        _smartySubTitleLabel.alpha = 1- offsetRatio;
        _smartyTitleLabel.center = CGPointMake(offset/2+WINDOW_SIZE_WIDTH/2, titlesDistanceFromTopView) ;
        _smartySubTitleLabel.center = CGPointMake(WINDOW_SIZE_WIDTH/2+offset/1.5, titlesDistanceFromTopView + subTitleGap) ;
        
        [_startGameButton setTitle:@"NEXT"];

    }else if (offset/WINDOW_SIZE_WIDTH<2.0001)
        
    {
        _AITitleLabel.alpha = 2- offsetRatio;
        _AISubTitleLabel.alpha = 2- offsetRatio;
        _AITitleLabel.center = CGPointMake(offset/2, titlesDistanceFromTopView) ;
        _AISubTitleLabel.center = CGPointMake(offset/1.5 + offsetX, titlesDistanceFromTopView + subTitleGap) ;
        
        
        _MultiPlayerTitle.alpha = offsetRatio-1;
        _MultiPlayerTitle.center = CGPointMake(WINDOW_SIZE_WIDTH+WINDOW_SIZE_WIDTH/2 - offset/2, titlesDistanceFromTopView) ;
        _MultiPlayerSubTitle.center = CGPointMake(offset/1.5 + offsetX - slowOffset, titlesDistanceFromTopView +subTitleGap) ;
        _MultiPlayerSubTitle.alpha = offsetRatio-1;
        
        if (offsetRatio>1.5) {
            [_startGameButton setTitle:@"START"];
            [_startGameButton setButtomButtonColor:[UIColor lightBlue] withAnimation:YES];

        }else
        {
            [_startGameButton setTitle:@"NEXT"];
            [_startGameButton setButtomButtonColor:[UIColor backgrounDarkBlue] withAnimation:YES];



        }
        
    }else if (_scrollView.contentOffset.x/WINDOW_SIZE_WIDTH<3.0001)
    {
        
    }
    
    
    CGFloat pageWidth = WINDOW_SIZE_WIDTH;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    _currentPage = lround(fractionalPage);
    self.pageControl.currentPage = _currentPage;

}

-(CGPoint)addScrollViewOffset
{
    switch (_pageControl.currentPage) {
        case 0:
            return  CGPointMake(WINDOW_SIZE_WIDTH, 0);
            break;
            
        case 1:
            return  CGPointMake(WINDOW_SIZE_WIDTH*2, 0);
            break;
        default:
            break;
    }
    return  CGPointMake(0, 0);
}

-(void)contentOffsetWithAnimation:(CGPoint)flt
{
        [UIView animateWithDuration:0.5 animations:^ {
            [_scrollView setContentOffset:flt animated:YES];
        }];
}

-(void)buttonPress:(ButtomButton *)button
{
    switch ((int)_currentPage) {
        case 0:
            [self contentOffsetWithAnimation:[self addScrollViewOffset]];
            break;
            
        case 1:
            [self contentOffsetWithAnimation:[self addScrollViewOffset]];
            break;
            
        case 2:
                [self fadeoutViewControllerAnimation];
            break;
            
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
