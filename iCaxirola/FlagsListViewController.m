//
//  FlagsListViewController.m
//  iCaxirola
//
//  Created by fumiharu on 2014/02/17.
//  Copyright (c) 2014年 FumiharuSugawara. All rights reserved.
//

#import "FlagsListViewController.h"
#import "ViewController.h"


@interface FlagsListViewController ()
{
    UIButton *flagSelectBtn;
    UIButton *closeBtn;
    UIScrollView *scroll;
    UIImageView *InitialValue;
    NSUserDefaults *ud;
}
@end

@implementation FlagsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ViewController *asd = [[ViewController alloc]init];
    _delegate = asd.self;
    
    //animation view.
    self.view.alpha = 0;
    self.view.backgroundColor = [UIColor blackColor];
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    self.view.alpha = 1;
    [UIView commitAnimations];


    scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [scroll setBackgroundColor:[UIColor blackColor]];
    scroll.contentSize = CGSizeMake(0, 1200);
    [self.view addSubview:scroll];
    [self.view AdMobBanner];
    
//  保存データ取得
    ud = [NSUserDefaults standardUserDefaults];
    NSString *stringRect = [ud stringForKey:@"wefff"];
    CGRect rectWithRect = CGRectFromString(stringRect);
    InitialValue = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected.png"]];
    
//    座標が NULL なら非表示. NULL でなければ表示
    if (stringRect == NULL) {
        InitialValue.frame = CGRectMake(0, 0, 0, 0);
    }else{
    InitialValue.frame = CGRectMake(rectWithRect.origin.x, rectWithRect.origin.y, 30, 30);
    }


    NSArray *arrayImage = [NSArray arrayWithObjects:kBRA, kMEX, kCMR, kCRO, kESP, kNED, kCHI, kAUS, kCOL, kGRE, kCIV, kJPN, kURU, kCRC, kENG, kITA, kSUI, kECU, kFRA, kHON, kARG, kBIH, kIRN, kNGA, kGRE, kPOR, kGHA, kUSA, kBEL, kALG, kRUS, kKOR, nil];
    NSArray *arrayName = [NSArray arrayWithObjects:kE_BRA, kE_MEX, kE_CMR, kE_CRO, kE_ESP,kE_NED, kE_CHI, kE_AUS, kE_COL, kE_GRE, kE_CIV, kE_JPN, kE_URU, kE_CRC, kE_ENG, kE_ITA, kE_SUI, kE_ECU, kE_FRA, kE_HON, kE_ARG, kE_BIH, kE_IRN, kE_NGA, kE_GRE, kE_POR, kE_GHA, kE_USA, kE_BEL, kE_ALG, kE_RUS, kE_KOR, nil];

    
//    ボタンの配置
    int y = 80;
    int z = 165;
    int x = 0;
    
    for (int i = 0; i < [arrayImage count]; i++){
        if (i % 4 == 0 && i > 0) {
            x = 0;
            y = y + 140;
            z = z + 140;
        }
        flagSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake((x*130), y, 85, 85)];
        [flagSelectBtn setBackgroundImage:[UIImage imageNamed:[arrayImage objectAtIndex:i]] forState:UIControlStateNormal];
        [flagSelectBtn addTarget:self action:@selector(pressFlagSelected:) forControlEvents:UIControlEventTouchUpInside];
        flagSelectBtn.tag = i;
        [scroll addSubview:flagSelectBtn];
        [scroll addSubview:InitialValue];
        
        UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake((x*130), z, 85, 25)];
        [Name setText:[arrayName objectAtIndex:i]];
        [Name setBackgroundColor:[UIColor blackColor]];
        [Name setTextColor:[UIColor whiteColor]];
        [Name setTextAlignment:NSTextAlignmentCenter];
        [Name setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:15]];
        Name.adjustsFontSizeToFitWidth = YES;
        [scroll addSubview:Name]; 
        
        x = x + 1;
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 400, 40)];
    [title setText:@"Change The Design for iCaxirola."];
    [title setBackgroundColor:[UIColor blackColor]];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:20]];
    [scroll addSubview:title];
    
    closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(500, 30, 40, 50)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}




-(void)pressFlagSelected:(UIButton*)bota{
    if ([_delegate respondsToSelector:@selector(method:)]) {
        [_delegate method:bota];
    }

    for (UIView *viu in scroll.subviews) {
        if ([viu isMemberOfClass:([UIImageView class])]) {
            [viu removeFromSuperview];
        }
    }
    
    
//    UIImageView *
    InitialValue = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected.png"]];
    InitialValue.frame = CGRectMake(bota.frame.origin.x, bota.frame.origin.y, 30, 30);
    [scroll addSubview:InitialValue];

    //フェードイン
    InitialValue.alpha = 0;
    //アニメーションのタイプを指定
    [UIView beginAnimations:@"fadeIn" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:0.5];
    //目標のアルファ値を指定
    InitialValue.alpha = 1;
    //アニメーション実行
    [UIView commitAnimations];
    
    
    NSString *str = NSStringFromCGRect(InitialValue.frame);
    [ud setObject:str forKey:@"wefff"];
    [ud synchronize];
    
//    Save the coordinates of the select button
    _ud1 = [NSUserDefaults standardUserDefaults];
    [_ud1 setInteger:bota.tag forKey:@"tag"];
    [_ud1 synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)remove{
//    self.view.alpha = 0.9;
    self.view.backgroundColor = [UIColor blackColor];
    //アニメーションのタイプを指定
    [UIView beginAnimations:@"fadeOut" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:0.3];
    //目標のアルファ値を指定
    self.view.alpha = 0;
    //アニメーション実行
    [UIView commitAnimations];
}
@end
