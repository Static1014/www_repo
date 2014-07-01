//
//  FiveViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "FiveViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FiveViewController ()

@end

@implementation FiveViewController
@synthesize myScrollView,pageControl;

-(void)initArray
{
    imageArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"image0.png"],[UIImage imageNamed:@"image1.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image3.png"],nil];
    //存放图片的数组

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArray];
    [self configScrollView];
}
-(void)configScrollView
{

     //初始化UIScrollView，设置相关属性，均可在storyBoard中设置
     CGRect frame=CGRectMake(0, 0, 320, 180);
     self.myScrollView = [[UIScrollView alloc]initWithFrame:frame];    //scrollView的大小
     self.myScrollView.backgroundColor=[UIColor blueColor];
     self.myScrollView.pagingEnabled=YES;//以页为单位滑动，即自动到下一页的开始边界
     self.myScrollView.showsVerticalScrollIndicator=NO;
     self.myScrollView.showsHorizontalScrollIndicator=NO;//隐藏垂直和水平显示条

    self.myScrollView.delegate=self;
    UIImageView *firstView=[[UIImageView alloc] initWithImage:[imageArray lastObject]];
    CGFloat Width=self.myScrollView.frame.size.width;
    CGFloat Height=self.myScrollView.frame.size.height;
    firstView.frame=CGRectMake(0, 0, Width, Height);
    [self.myScrollView addSubview:firstView];
    //set the last as the first

    for (int i=0; i<[imageArray count]; i++) {
        UIImageView *subViews=[[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        subViews.frame=CGRectMake(Width*(i+1), 0, Width, Height);
        [self.myScrollView addSubview: subViews];
    }

    UIImageView *lastView=[[UIImageView alloc] initWithImage:[imageArray objectAtIndex:0]];
    lastView.frame=CGRectMake(Width*(imageArray.count+1), 0, Width, Height);
    [self.myScrollView addSubview:lastView];
    //set the first as the last

    [self.myScrollView setContentSize:CGSizeMake(Width*(imageArray.count+2), Height)];
    [self.view addSubview:self.myScrollView];
    [self.myScrollView scrollRectToVisible:CGRectMake(Width, 0, Width, Height) animated:NO];
    //show the real first image,not the first in the scrollView


     //设置pageControl的位置，及相关属性，可选
     CGRect pageControlFrame=CGRectMake(100, 160, 78, 36);
     self.pageControl=[[UIPageControl alloc]initWithFrame:pageControlFrame];

     [self.pageControl setBounds:CGRectMake(0, 0, 16*(self.pageControl.numberOfPages-1), 16)];//设置pageControl中点的间距为16
     [self.pageControl.layer setCornerRadius:8];//设置圆角

    self.pageControl.numberOfPages=imageArray.count;
    //    self.pageControl.backgroundColor=[UIColor blueColor];//背景
    self.pageControl.currentPage=0;
    self.pageControl.enabled=YES;
    [self.view addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];

    myTimer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];

}

#pragma UIScrollView delegate
-(void)scrollToNextPage:(id)sender
{
    int pageNum=self.pageControl.currentPage;
    CGSize viewSize=self.myScrollView.frame.size;
    CGRect rect=CGRectMake((pageNum+2)*viewSize.width, 0, viewSize.width, viewSize.height);
    [self.myScrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum==imageArray.count) {
        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.myScrollView scrollRectToVisible:newRect animated:NO];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth=self.myScrollView.frame.size.width;
    int currentPage=floor((self.myScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    if (currentPage==0) {
        self.pageControl.currentPage=imageArray.count-1;
    }else if(currentPage==imageArray.count+1){
        self.pageControl.currentPage=0;
    }
    self.pageControl.currentPage=currentPage-1;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [myTimer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    myTimer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth=self.myScrollView.frame.size.width;
    CGFloat pageHeigth=self.myScrollView.frame.size.height;
    int currentPage=floor((self.myScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    NSLog(@"the current offset==%f",self.myScrollView.contentOffset.x);
    NSLog(@"the current page==%d",currentPage);

    if (currentPage==0) {
        [self.myScrollView scrollRectToVisible:CGRectMake(pageWidth*imageArray.count, 0, pageWidth, pageHeigth) animated:NO];
        self.pageControl.currentPage=imageArray.count-1;
        NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);
        NSLog(@"the last image");
        return;
    }else  if(currentPage==[imageArray count]+1){
        [self.myScrollView scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
        self.pageControl.currentPage=0;
        NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);
        NSLog(@"the first image");
        return;
    }
    self.pageControl.currentPage=currentPage-1;
    NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);

}
-(IBAction)pageTurn:(UIPageControl *)sender
{
    int pageNum=pageControl.currentPage;
    CGSize viewSize=self.myScrollView.frame.size;
    [self.myScrollView setContentOffset:CGPointMake((pageNum+1)*viewSize.width, 0)];
    NSLog(@"myscrollView.contentOffSet.x==%f",myScrollView.contentOffset.x);
    NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);   [myTimer invalidate];
}

@end