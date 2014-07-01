//
//  FiveViewController.h
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiveViewController : UIViewController <UIScrollViewDelegate>
{
    NSMutableArray *imageArray;//存放图片
    NSTimer *myTimer;//定时器

}
@property(nonatomic,retain) IBOutlet UIScrollView *myScrollView;
@property(nonatomic,retain) IBOutlet UIPageControl *pageControl;

-(IBAction)pageTurn:(UIPageControl *)sender;
@end
