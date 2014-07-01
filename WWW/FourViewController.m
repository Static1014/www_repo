//
//  FourViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "FourViewController.h"
#import "BusinessUtil.h"

@interface FourViewController ()

@end

@implementation FourViewController

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
    self.view.backgroundColor = [UIColor purpleColor];

    [self initScrollView];
    [self initPageControl];
}

- (void)initPageControl {
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
}

- (void)initScrollView {
    _pageScrollView.delegate = self;
    _pageScrollView.tag = 11;

    for (int i=0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[BusinessUtil scaleImageWithImageSimple:image scaledToSize:_pageScrollView.frame.size]];
        imageView.tag = i;
        imageView.frame = CGRectMake(i*320, 0, 320, 180);

        [_pageScrollView addSubview:imageView];
        [imageView release];
    }

    _pageScrollView.contentSize = CGSizeMake(320*4, 1);

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    singleTap.cancelsTouchesInView = NO;
    [_pageScrollView addGestureRecognizer:singleTap];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    if (sView.tag == 11)
    {
        NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
        [_pageControl setCurrentPage:index];
    }
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:_pageScrollView];
    NSInteger index = touchPoint.x/320;

    NSLog(@"------%d",(int)index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_pageScrollView release];
    [_pageControl release];
    [super dealloc];
}
- (IBAction)pageValueChanged:(id)sender {
    UIPageControl *page = (UIPageControl*)sender;
    [_pageScrollView scrollRectToVisible:CGRectMake(page.currentPage*320, 0, 320, 180) animated:YES];
}
@end
