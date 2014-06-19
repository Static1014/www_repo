//
//  ThreeViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-16.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "ThreeViewController.h"
#import "FourViewController.h"

@interface ThreeViewController () {
    UIProgressView *progress;
}

@end

@implementation ThreeViewController

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

    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
}

- (void)changeProgress {
    progress.progress += 0.02;
    if (progress.progress >= 1) {
        progress.progress = 0;
    }
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.translucent = NO;

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 158, 44)];
    bgView.backgroundColor = [UIColor clearColor];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(4, 2, 150, 20)];
    title.text = @"Navigation Test";
    title.textColor = [UIColor redColor];
    title.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:title];
    [title release];

    progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.progress = 0.3;
    progress.frame = CGRectMake(4, 30, 150, 12);

    [bgView addSubview:progress];
    [progress release];

    self.navigationItem.titleView = bgView;
    [bgView release];

    UIButton *left1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [left1 setImage:[UIImage imageNamed:@"tab_s1.png"] forState:UIControlStateNormal];
    [left1 setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateHighlighted];
    [left1 setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *l1 = [[UIBarButtonItem alloc]initWithCustomView:left1];

    UIBarButtonItem *l2 = [[UIBarButtonItem alloc]initWithTitle:@"L2" style:UIBarButtonItemStylePlain target:self action:@selector(clickL2:)];

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:l1,l2, nil];
    [l1 release];
    [l2 release];

    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right1 setImage:[UIImage imageNamed:@"tab_s1.png"] forState:UIControlStateNormal];
    [right1 setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateHighlighted];
    [right1 setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *r1 = [[UIBarButtonItem alloc]initWithCustomView:right1];

    UIBarButtonItem *r2 = [[UIBarButtonItem alloc]initWithTitle:@"R2" style:UIBarButtonItemStylePlain target:self action:@selector(clickR2:)];

    NSArray *rightItems = [NSArray arrayWithObjects:r1,r2, nil];
    self.navigationItem.rightBarButtonItems = rightItems;
    [r2 release];
    [r1 release];

//    NSLog(@"%@",[self.navigationController.navigationBar.subviews description]);
}

- (void)clickR2:(UIBarButtonItem*)btn {
    NSLog(@"----------R2");

    FourViewController *four = [[FourViewController alloc]initWithNibName:@"FourViewController" bundle:nil];
    four.title = @"Four Page";
    [self.navigationController pushViewController:four animated:YES];
    [four release];
}

- (void)clickL2:(UIBarButtonItem*)btn {
    NSLog(@"-----L2");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
