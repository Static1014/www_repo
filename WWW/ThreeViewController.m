//
//  ThreeViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-16.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

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
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Navigation Test";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
