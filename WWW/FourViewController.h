//
//  FourViewController.h
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourViewController : UIViewController<UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)pageValueChanged:(id)sender;
@end
