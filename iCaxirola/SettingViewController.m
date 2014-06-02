//
//  SettingViewController.m
//  iCaxirola
//
//  Created by fumiharu on 2014/02/12.
//  Copyright (c) 2014年 FumiharuSugawara. All rights reserved.


#import "SettingViewController.h"
#import "ViewController.h"

@interface SettingViewController ()
{
    UIButton *flagSelectBtn;
    UIButton *closeBtn;
    UIScrollView *scroll;
    UIImageView *InitialValue;
    UIView *SettingSubView;
    NSUserDefaults *ud;
}
- (IBAction)CloseBtn:(id)sender;
- (IBAction)pressFlagsListView:(id)sender;
@end

@implementation SettingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view AdMobBanner];
}

- (IBAction)pressFlagsListView:(id)sender {
    SettingSubView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];  //CGRectMake(45, 40, 480, 270)
    SettingSubView.alpha = 0;
    SettingSubView.backgroundColor = [UIColor blackColor];
//    SettingSubView.layer.cornerRadius = 10;
    SettingSubView.clipsToBounds = true;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    SettingSubView.alpha = 0.9;
    [UIView commitAnimations];
    [self.view addSubview:SettingSubView];
    
    scroll = [[UIScrollView alloc]initWithFrame:SettingSubView.bounds];
    [scroll setBackgroundColor:[UIColor blackColor]];
    scroll.contentSize = CGSizeMake(0, 1150);
    [SettingSubView addSubview:scroll];
    [self.view AdMobBanner];
    
    //    Place a button
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
    int columns = 5;
    
    for (int i = 0; i < [arrayImage count]; i++){
        if (i % columns == 0 && i > 0) {
            x = 0;
            y = y + 130;
            z = z + 130;
        }
        flagSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(((scroll.bounds.size.width/columns)*x), y, 85, 85)];
        [flagSelectBtn setBackgroundImage:[UIImage imageNamed:[arrayImage objectAtIndex:i]] forState:UIControlStateNormal];
        [flagSelectBtn addTarget:self action:@selector(pressFlagSelected:) forControlEvents:UIControlEventTouchUpInside];
        flagSelectBtn.tag = i;
        [scroll addSubview:flagSelectBtn];
        
        [scroll addSubview:InitialValue];
        
        UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(((scroll.bounds.size.width/columns)*x), z, 85, 25)];
        [Name setText:[arrayName objectAtIndex:i]];
        [Name setBackgroundColor:[UIColor blackColor]];
        [Name setTextColor:[UIColor whiteColor]];
        [Name setTextAlignment:NSTextAlignmentCenter];
        [Name setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:15]];
        Name.adjustsFontSizeToFitWidth = YES;
        [scroll addSubview:Name];
        
        x = x + 1;
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 400, 40)];
    [title setText:@"Change The Design for iCaxirola."];
    [title setBackgroundColor:[UIColor blackColor]];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:20]];
    [scroll addSubview:title];
    
    closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(490, 25, 40, 50)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(removee) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}


-(void)pressFlagSelected:(UIButton*)bota{
    ViewController *vc = [[ViewController alloc]init];
    vc.mainCaxirola.image = [UIImage imageNamed:kMEX];
    [vc.mainCaxirola setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kMEX]]];
    
    for (UIView *viu in scroll.subviews) {
        if ([viu isMemberOfClass:([UIImageView class])]) {
            [viu removeFromSuperview];
        }
    }
    
    InitialValue = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected.png"]];
    InitialValue.frame = CGRectMake(bota.frame.origin.x, bota.frame.origin.y, 30, 30);
    [scroll addSubview:InitialValue];
    
    InitialValue.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    InitialValue.alpha = 1;
    [UIView commitAnimations];
    
    NSString *str = NSStringFromCGRect(InitialValue.frame);
    [ud setObject:str forKey:@"wefff"];
    [ud synchronize];
    
    //    Save the coordinates of the select button
    _ud1 = [NSUserDefaults standardUserDefaults];
    [_ud1 setInteger:bota.tag forKey:@"tag"];
    [_ud1 synchronize];
}

-(void)removee{
    SettingSubView.alpha = 0.9;
    closeBtn.alpha = 0.9;
    SettingSubView.backgroundColor = [UIColor blackColor];
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    SettingSubView.alpha = 0;
    closeBtn.alpha = 0;
    [UIView commitAnimations];
}

- (IBAction)CloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    ViewController *vc = [[ViewController alloc]init];
    vc.mainCaxirola.image = [UIImage imageNamed:kMEX];
    [vc.mainCaxirola setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kMEX]]];
    [vc viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
