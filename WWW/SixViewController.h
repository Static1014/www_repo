//
//  SixViewController.h
//  WWW
//
//  Created by XiongJian on 14-7-2.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIView *rightMenuView;

- (IBAction)clickBtn1:(id)sender;
- (IBAction)touchMenuExit:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *btnView;
@property (retain, nonatomic) IBOutlet UIButton *btnSet;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property (retain, nonatomic) IBOutlet UIButton *btn5;
@property (retain, nonatomic) IBOutlet UIButton *btn6;
@property (retain, nonatomic) IBOutlet UIButton *btn7;
@property (retain, nonatomic) IBOutlet UIButton *btn8;
- (IBAction)clickBtnSet:(id)sender;

@end
