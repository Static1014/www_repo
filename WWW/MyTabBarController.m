//
//  MyTabBarController.m
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()
{
    int defaultTab;

    UIImageView *bgView;
    UILabel *indicator;
}
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
    defaultTab = 1;

    [self setMyViewControllers];
    [self initMyTabBarItems];
}

- (void)viewDidAppear:(BOOL)animated {
    self.selectedIndex = defaultTab;
}

- (void)initMyTabBarItems {
    bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 431, 320, 49)];
    bgView.tag = 999;
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bgView];
    [bgView release];

    int space = (320 - 30 * 4) / (4 + 1);

    for (int i = 0;i < 4;i++) {
        NSString *imageNameNormal = [NSString stringWithFormat:@"tab_%d.png",i];
        NSString *imageNameSelected = [NSString stringWithFormat:@"tab_s%d.png",i];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageNameNormal] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameSelected] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabBarDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.selected = i==defaultTab?YES:NO;
        [btn setFrame:CGRectMake(space*(i+1) +30*i, (49-30)/2, 30, 30)];

        [bgView addSubview:btn];

        CGRect frame = btn.frame;
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x + 20, frame.origin.y - 6, 15, 15)];
        lable.tag = i;
        [lable.layer setCornerRadius:8];
        lable.backgroundColor = [UIColor redColor];
        lable.text = @"9";
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;

        lable.hidden = YES;
        [bgView addSubview:lable];
    }

    indicator = [[UILabel alloc]initWithFrame:CGRectMake(space*(defaultTab+1) +30*defaultTab, 42, 30, 2)];
    indicator.tag = 333;
    indicator.backgroundColor = [UIColor purpleColor];
    [bgView addSubview:indicator];
    [indicator release];
}

- (void)showOneMsg:(BOOL)hidden withNum:(int)num {
    for (UIView *temp in bgView.subviews) {
        if ([temp isKindOfClass:[UILabel class]] && temp.tag == 0) {
            UILabel *lable = (UILabel*)temp;
            lable.hidden = hidden;
            if (!hidden) {
                if (num < 100) {
                    lable.text = [NSString stringWithFormat:@"%d",num];
                    lable.font = [UIFont systemFontOfSize:num>9?10:12];
                } else {
                    lable.text = @"∞";
                    lable.font = [UIFont systemFontOfSize:14];
                }
            }
        }
    }
}

- (void)tabBarDidSelected:(UIButton *)btn {
    self.selectedIndex = btn.tag;

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

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = indicator.frame;
        frame.origin.x = x;
        [indicator setFrame:frame];
    }];
}

- (void)setMyViewControllers {
    OneViewController *view = [[OneViewController alloc]initWithNibName:@"OneViewController" bundle:nil];
    view.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:view];
    [view release];

    ThreeViewController *view1 = [[ThreeViewController alloc]initWithNibName:@"ThreeViewController" bundle:nil];
    UINavigationController *navc1 = [[UINavigationController alloc] initWithRootViewController:view1];
    [view1 release];

    FourViewController *view2 = [[FourViewController alloc]initWithNibName:@"FourViewController" bundle:nil];

    FiveViewController *view3 = [[FiveViewController alloc]initWithNibName:@"FiveViewController" bundle:nil];

    self.viewControllers = [NSArray arrayWithObjects:navc, navc1, view2, view3, nil];
    [navc release];
    [navc1 release];
    [view2 release];
    [view3 release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
