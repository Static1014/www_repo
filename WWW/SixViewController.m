//
//  SixViewController.m
//  WWW
//
//  Created by XiongJian on 14-7-2.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "SixViewController.h"
#import <QuartzCore/CoreAnimation.h>

@interface SixViewController ()

@end

@implementation SixViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_rightMenuView release];
    [_btnSet release];
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [_btn4 release];
    [_btn5 release];
    [_btn6 release];
    [_btn7 release];
    [_btn8 release];
    [_btnView release];
    [super dealloc];
}

#pragma mark - RIGHT MENU
- (void)setNavigationBar {
    UIBarButtonItem *menuBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(setRightMenuLocation)];
    self.navigationItem.rightBarButtonItem = menuBarBtn;
}

- (IBAction)clickBtn1:(id)sender {
    [self setRightMenuLocation];
    NSLog(@"-------1111");
}

- (IBAction)touchMenuExit:(id)sender {
    [self setRightMenuLocation];
}

- (void)setRightMenuLocation {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _rightMenuView.frame;
        if (frame.origin.x == 320) {
            frame.origin.x -= frame.size.width;
        } else if (frame.origin.x == 0) {
            frame.origin.x += frame.size.width;
        }
        _rightMenuView.frame = frame;
    }];
}

#pragma mark - BUTTON SET
- (IBAction)clickBtnSet:(id)sender {
    [self setSetBtnsLocations];
}

- (void)setSetBtnsLocations {
    BOOL isOpen = _btn1.frame.size.width==32?YES:NO;

    [UIView animateWithDuration:1 animations:^{
        CGAffineTransform trans = _btnView.transform;
        trans = CGAffineTransformTranslate(trans, isOpen?-100:100, isOpen?-100:100);
        _btnView.transform = trans;

        CGAffineTransform transform = _btnSet.transform;
        transform = CGAffineTransformRotate(transform, isOpen?-4:4);
        transform = CGAffineTransformScale(transform, isOpen?0.5:2, isOpen?0.5:2);
        _btnSet.transform = transform;

        CGRect frame = _btn8.frame;
        frame.origin.x = isOpen?120:64;
        frame.origin.y = isOpen?120:64;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn8.frame = frame;
    }];
    [UIView animateWithDuration:0.875 animations:^{
        CGRect frame = _btn7.frame;
        frame.origin.x = isOpen?120:48;
        frame.origin.y = isOpen?120:104;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn7.frame = frame;
    }];
    [UIView animateWithDuration:0.75 animations:^{
        CGRect frame = _btn6.frame;
        frame.origin.x = isOpen?120:64;
        frame.origin.y = isOpen?120:144;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn6.frame = frame;
    }];
    [UIView animateWithDuration:0.625 animations:^{
        CGRect frame = _btn5.frame;
        frame.origin.x = isOpen?120:104;
        frame.origin.y = isOpen?120:160;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn5.frame = frame;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _btn4.frame;
        frame.origin.x = isOpen?120:144;
        frame.origin.y = isOpen?120:144;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn4.frame = frame;
    }];
    [UIView animateWithDuration:0.375 animations:^{
        CGRect frame = _btn3.frame;
        frame.origin.x = isOpen?120:160;
        frame.origin.y = isOpen?120:104;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn3.frame = frame;
    }];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _btn2.frame;
        frame.origin.x = isOpen?120:144;
        frame.origin.y = isOpen?120:64;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn2.frame = frame;
    }];
    [UIView animateWithDuration:0.125 animations:^{
        CGRect frame = _btn1.frame;
        frame.origin.x = isOpen?120:104;
        frame.origin.y = isOpen?120:48;
        frame.size.width = isOpen?0:32;
        frame.size.height = isOpen?0:32;
        _btn1.frame = frame;
    }];
}
@end
