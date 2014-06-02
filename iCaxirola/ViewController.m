//
//  ViewController.m
//  iCaxirola
//
//  Created by fumiharu on 2014/02/12.
//  Copyright (c) 2014年 FumiharuSugawara. All rights reserved.
//
#import "ViewController.h"
#import "UIView+iCaxirola.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "GADBannerView.h"
#import "Params.h"

typedef enum : NSUInteger {
    brz = 0,
    cmr,
} asd;

@interface ViewController ()
{
    AVAudioPlayer *SoundAudio0;
    AVAudioPlayer *SoundAudio1;
    AVAudioPlayer *SoundAudio2;
    AVAudioPlayer *SoundAudio3;
    AVAudioPlayer *SoundAudio4;
    SystemSoundID soundSystem;
    UIButton *flagSelectBtn;
    UIButton *pressCloseFLW;
    UIScrollView *scrollView;
    UIImageView *InitialValue;
    UIView *flagsListWindow;
    NSUserDefaults *ud;
    NSArray *listImages;
    NSArray *mainImages;
    NSArray *arrayName;
    NSArray *flagKeys;
    UIImageView *plus;
    UIImageView *menu;
    UIImageView *facebook;
    UIImageView *twitter;
}
@property (nonatomic, strong) IBOutlet UIImageView *mainCaxirola;
@property (nonatomic, strong) NSUserDefaults *ud1;
@property (strong, nonatomic) IBOutlet UIWebView *WebView;
@property (strong, nonatomic) UIImageView *menuu;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    _mainCaxirola.image = [UIImage imageNamed:@"m1_brazil@2x.png"];
    _mainCaxirola.backgroundColor = RGB(255, 217, 64);
    
    [_mainCaxirola addSubview:[self plus]];
    [_mainCaxirola addSubview:[self menu]];
    [_mainCaxirola addSubview:[self facebook]];
    [_mainCaxirola addSubview:[self twitter]];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)openChengeFlag
{
            [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
            UIView *adBaseView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, 0, self.view.bounds.size.width, 75)];
            adBaseView.backgroundColor = RGB(50, 50, 49);
            
            flagsListWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            flagsListWindow.alpha = 0;
            flagsListWindow.backgroundColor = RGB(50, 50, 49);
            flagsListWindow.clipsToBounds = true;
            [UIView beginAnimations:@"fadeIn" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.2];
            flagsListWindow.alpha = 1;
            [UIView commitAnimations];
            [self.view addSubview:flagsListWindow];
            
            scrollView = [[UIScrollView alloc]initWithFrame:flagsListWindow.bounds];
            [scrollView setBackgroundColor:RGB(50, 50, 49)];
            scrollView.contentSize = CGSizeMake(0, 1110);
            [flagsListWindow addSubview:scrollView];
            [flagsListWindow addSubview:adBaseView];
            [adBaseView addSubview:[self AdMobBanner]];
            
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
            
            
            listImages = [NSArray arrayWithObjects:kBRA, kCRO, kMEX, kCMR,
                          kESP, kNED, kCHI, kAUS,
                          kCOL, kGRE, kCIV, kJPN,
                          kURU, kCRC, kENG, kITA,
                          kSUI, kECU, kFRA,
                          kARG, kBIH, kIRN, kNGA,
                          kGRE, kPOR, kGHA, kUSA,
                          kBEL, kALG, kRUS, kKOR, nil];
            mainImages = [NSArray arrayWithObjects:k_BRA, k_CRO, k_MEX, k_CMR,
                          k_ESP, k_NED, k_CHI, k_AUS,
                          k_COL, k_GRE, k_CIV, k_JPN,
                          k_URU, k_CRC, k_ENG, k_ITA,
                          k_SUI, k_ECU, k_FRA,
                          k_ARG, k_BIH, k_IRN, k_NGA,
                          k_GRE, k_POR, k_GHA, k_USA,
                          k_BEL, k_ALG, k_RUS, k_KOR, nil];
            arrayName = [NSArray arrayWithObjects:kE_BRA, kE_CRO, kE_MEX, kE_CMR,
                         kE_ESP, kE_NED, kE_CHI, kE_AUS,
                         kE_COL, kE_GRE, kE_CIV, kE_JPN,
                         kE_URU, kE_CRC, kE_ENG, kE_ITA,
                         kE_SUI, kE_ECU, kE_FRA,
                         kE_ARG, kE_BIH, kE_IRN, kE_NGA,
                         kE_GRE, kE_POR, kE_GHA, kE_USA,
                         kE_BEL, kE_ALG, kE_RUS, kE_KOR, nil];
            flagKeys = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", nil];
            
            
            //    ボタンの配置
            int y = 80;
            int z = 165;
            int x = 0;
            int columns = 4;
            
            for (int i = 0; i < [listImages count]; i++){
                if (i % columns == 0 && i > 0) {
                    x = 0;
                    y = y + 130;
                    z = z + 130;
                }
                flagSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(((scrollView.bounds.size.width/columns)*x), y, 85, 85)];
                [flagSelectBtn setBackgroundImage:[UIImage imageNamed:[listImages objectAtIndex:i]] forState:UIControlStateNormal];
                [flagSelectBtn addTarget:self action:@selector(pressFlagSelected:) forControlEvents:UIControlEventTouchUpInside];
                flagSelectBtn.tag = i;
                [scrollView addSubview:flagSelectBtn];
                
                [scrollView addSubview:InitialValue];
                
                UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(((scrollView.bounds.size.width/columns)*x), z, 85, 25)];
                [Name setText:[arrayName objectAtIndex:i]];
                [Name setBackgroundColor:RGB(50, 50, 49)];
                [Name setTextColor:[UIColor whiteColor]];
                [Name setTextAlignment:NSTextAlignmentCenter];
                [Name setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:15]];
                Name.adjustsFontSizeToFitWidth = YES;
                [scrollView addSubview:Name];
                
                x = x + 1;
            }
            
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 400, 40)];
            [title setText:@"Change The Design for iCaxirola."];
            [title setBackgroundColor:RGB(50, 50, 49)];
            [title setTextColor:[UIColor whiteColor]];
            [title setTextAlignment:NSTextAlignmentCenter];
            [title setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:20]];
            [adBaseView addSubview:title];
            
            pressCloseFLW = [[UIButton alloc]initWithFrame:CGRectMake(517, 35, 45, 45)];
            [pressCloseFLW setBackgroundImage:[UIImage imageNamed:@"btn_plus@2x.png"] forState:UIControlStateNormal];
            [pressCloseFLW addTarget:self action:@selector(removee) forControlEvents:UIControlEventTouchUpInside];
            [adBaseView addSubview:pressCloseFLW];
}

-(void)pressFlagSelected:(UIButton*)flagButton{
    NSString *flagButtonTag = [NSString stringWithFormat:@"%d", flagButton.tag];
    NSDictionary *flagDict = [NSDictionary dictionaryWithObjects:mainImages forKeys:flagKeys];
    NSString *flagImageName = [flagDict objectForKey:flagButtonTag];
    _mainCaxirola.image = [UIImage imageNamed:flagImageName];
    
    //change the Flags backbround color
    if ([flagButtonTag isEqualToString:@"0"]||
        [flagButtonTag isEqualToString:@"4"]) {
        _mainCaxirola.backgroundColor = RGB(255, 217, 64);
    }else if ([flagButtonTag isEqualToString:@"11"]){
        _mainCaxirola.backgroundColor = RGB(225, 224, 221);
    }else{
        _mainCaxirola.backgroundColor = RGB(235, 234, 230);
    }
    
    
    for (UIView *view in scrollView.subviews) {
        if ([view isMemberOfClass:([UIImageView class])]) {
            [view removeFromSuperview];
        }
    }
    
    InitialValue = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected.png"]];
    InitialValue.frame = CGRectMake(flagButton.frame.origin.x, flagButton.frame.origin.y, 30, 30);
    [scrollView addSubview:InitialValue];
    
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
    [_ud1 setInteger:flagButton.tag forKey:@"tag"];
    [_ud1 synchronize];
}

-(void)removee{
    flagsListWindow.alpha = 0.9;
    pressCloseFLW.alpha = 0.9;
    flagsListWindow.backgroundColor = RGB(50, 50, 49);
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    flagsListWindow.alpha = 0;
    pressCloseFLW.alpha = 0;
    [UIView commitAnimations];
    [self tapMenuButtonFadeOut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setAudio00{
    NSURL *url1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"maracas0" ofType:@"wav"]];
    SoundAudio0 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    [SoundAudio0 prepareToPlay];
}
-(void)setAudio01{
    NSURL *url1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"maracas0" ofType:@"wav"]];
    SoundAudio2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    [SoundAudio2 prepareToPlay];
}

-(void)setAudio10{
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"maracas1" ofType:@"wav"]];
    SoundAudio1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    [SoundAudio1 prepareToPlay];

}
-(void)setAudio11{
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"maracas1" ofType:@"wav"]];
    SoundAudio3 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    [SoundAudio3 prepareToPlay];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setAudio00];
    [SoundAudio0 play];
    [self setAudio01];
    [SoundAudio2 play];
    [self setAudio10];
    [SoundAudio1 play];
    [self setAudio11];
    [SoundAudio3 play];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAudio00];
    [SoundAudio0 play];
    [self setAudio01];
    [SoundAudio2 play];
    [self setAudio10];
    [SoundAudio1 play];
    [self setAudio11];
    [SoundAudio3 play];
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self setAudio00];
    [SoundAudio0 play];
    [self setAudio01];
    [SoundAudio2 play];
    [self setAudio10];
    [SoundAudio1 play];
    [self setAudio11];
    [SoundAudio3 play];
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self setAudio00];
    [SoundAudio0 play];
    [self setAudio01];
    [SoundAudio2 play];
    [self setAudio10];
    [SoundAudio1 play];
    [self setAudio11];
    [SoundAudio3 play];
}
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self setAudio00];
    [SoundAudio0 play];
    [self setAudio01];
    [SoundAudio2 play];
    [self setAudio10];
    [SoundAudio1 play];
    [self setAudio11];
    [SoundAudio3 play];
}
- (void)openMenuButtonFadeIn
{
    if (menu.alpha == 1) {
        [self tapMenuButtonFadeOut];
    }else if (menu.alpha == 0){
    //フェードイン
    [UIView beginAnimations:@"fadeIn" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:0.3];
    //目標のアルファ値を指定
    menu.alpha = 1;
    facebook.alpha = 1;
    twitter.alpha = 1;
    //アニメーション実行
    [UIView commitAnimations];
}
}

- (void)tapMenuButtonFadeOut
{
    //フェードアウト
    [UIView beginAnimations:@"fadeOut" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:0.15];
    //目標のアルファ値を指定
    facebook.alpha = 0;
    twitter.alpha = 0;
    menu.alpha = 0;
    //アニメーション実行
    [UIView commitAnimations];
}

-(void)fb{
    SLComposeViewController *typeFacebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [typeFacebook setInitialText:@"Feeling right now?!"];
    [self presentViewController:typeFacebook animated:YES completion:nil];
    
    //    NSURL *url = [NSURL URLWithString:@"http://touch.fifa.com/worldcup/matches/index.html"];
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //    UIViewController *vvv = [[UIViewController alloc]initWithNibName:@"WebView" bundle:nil];
    //    [_WebView loadRequest:req];
}

-(void)tw{
    SLComposeViewController *typeTwitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [typeTwitter setInitialText:@"Feeling right now?! #"];
    [self presentViewController:typeTwitter animated:YES completion:nil];

}

-(UIImageView *)facebook{
    facebook = [[UIImageView alloc]initWithFrame:CGRectMake(self.mainCaxirola.frame.size.width/1.188, self.mainCaxirola.frame.size.height/2.25, 90, 90)];
    [facebook setImage:[UIImage imageNamed:@"btn_facebook@2x.png"]];
    facebook.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fb)];
    [facebook addGestureRecognizer:tapGesture];
    facebook.userInteractionEnabled = YES;
    return facebook;
}

-(UIImageView *)twitter{
    twitter = [[UIImageView alloc]initWithFrame:CGRectMake(self.mainCaxirola.frame.size.width/1.45, self.mainCaxirola.frame.size.height/2.25, 90, 90)];
    [twitter setImage:[UIImage imageNamed:@"btn_twitter@2x.png"]];
    twitter.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tw)];
    [twitter addGestureRecognizer:tapGesture];
    twitter.userInteractionEnabled = YES;
    return twitter;
}

-(UIImageView *)plus{
    plus = [[UIImageView alloc]initWithFrame:CGRectMake(self.mainCaxirola.frame.size.width/1.188, self.mainCaxirola.frame.size.height/1.38, 90, 90)];
    [plus setImage:[UIImage imageNamed:@"btn_plus@2x.png"]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openMenuButtonFadeIn)];
    [plus addGestureRecognizer:tapGesture];
    plus.userInteractionEnabled = YES;
    return plus;
}

-(UIImageView *)menu{
    menu = [[UIImageView alloc]initWithFrame:CGRectMake(self.mainCaxirola.frame.size.width/1.45, self.mainCaxirola.frame.size.height/1.38, 90, 90)];
    [menu setImage:[UIImage imageNamed:@"btn_menu@2x.png"]];
    menu.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openChengeFlag)];
    [menu addGestureRecognizer:tapGesture];
    menu.userInteractionEnabled = YES;
    return menu;
}

- (UIView*)AdMobBanner{
    GADBannerView *bannerView = [[GADBannerView alloc]init];
    bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerLandscape];
    bannerView.adUnitID = kAdUnitID;
    bannerView.rootViewController = (UIViewController*)self;
    [bannerView loadRequest:[GADRequest request]];
    return bannerView;
}

@end
