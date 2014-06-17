//
//  MyTabBarController.m
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "MyTabBarController.h"
#import "OneViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

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

    self.tabBar.hidden = YES;

    [self setMyViewControllers];
    [self initMyTabBarItems];
}

- (void)initMyTabBarItems {
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 431, 320, 49)];
    bgView.tag = 999;
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bgView];
    [bgView release];

    int space = (320 - 30 * 4) / (4 + 1);
    for (int i = 0; i < 4; i++) {
        NSString *imageNameNormal = [NSString stringWithFormat:@"tab_%d.png",i];
        NSString *imageNameSelected = [NSString stringWithFormat:@"tab_s%d.png",i];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageNameNormal] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameSelected] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabBarDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.selected = i==0?YES:NO;
        [btn setFrame:CGRectMake(space*(i+1) +30*i, (49-30)/2, 30, 30)];

        [bgView addSubview:btn];
    }

    UILabel *indicator = [[UILabel alloc]initWithFrame:CGRectMake(space, 42, 30, 2)];
    indicator.tag = 333;
    indicator.backgroundColor = [UIColor purpleColor];
    [bgView addSubview:indicator];
    [indicator release];
}

- (void)tabBarDidSelected:(UIButton *)btn {
    self.selectedIndex = btn.tag;

    UIView *bgView = [self.view viewWithTag:999];
    CGFloat x = 0;

    for (UIView *view in bgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *temp = (UIButton*)view;
            if (temp.tag == btn.tag) {
                temp.selected = YES;
                x = temp.frame.origin.x;
            } else {
                temp.selected = NO;
            }
        }
    }

    UILabel *indicator = (UILabel*)[bgView viewWithTag:333];

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = indicator.frame;
        frame.origin.x = x;
        [indicator setFrame:frame];
    }];
}

- (void)setMyViewControllers {
    OneViewController *view = [[OneViewController alloc]initWithNibName:@"OneViewController" bundle:nil];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:view];
//    navc.tabBarItem.image = [UIImage imageNamed:@"lamp_inactive.png"];
    [view release];

    ThreeViewController *view1 = [[ThreeViewController alloc]initWithNibName:@"ThreeViewController" bundle:nil];
//    view1.tabBarItem.image = [UIImage imageNamed:@"star_3.png"];

    FourViewController *view2 = [[FourViewController alloc]initWithNibName:@"FourViewController" bundle:nil];
//    view2.tabBarItem.image = [UIImage imageNamed:@"tag_white.png"];

    FiveViewController *view3 = [[FiveViewController alloc]initWithNibName:@"FiveViewController" bundle:nil];
//    view3.tabBarItem.image = [UIImage imageNamed:@"flag_mark_gray.png"];

    self.viewControllers = [NSArray arrayWithObjects:navc, view1, view2, view3, nil];
    [navc release];
    [view1 release];
    [view2 release];
    [view3 release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
