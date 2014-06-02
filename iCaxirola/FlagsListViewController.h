//
//  FlagsListViewController.h
//  iCaxirola
//
//  Created by fumiharu on 2014/02/17.
//  Copyright (c) 2014年 FumiharuSugawara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Params.h"
#import "SettingViewController.h"
#import "UIView+iCaxirola.h"

@protocol FlagsListViewControllerDelegate <NSObject>
-(void)method:(UIButton*)btnTag;
@end

@interface FlagsListViewController : UIViewController
@property (nonatomic, strong) id<FlagsListViewControllerDelegate> delegate;
@property (nonatomic, strong) NSUserDefaults *ud1;
@end
