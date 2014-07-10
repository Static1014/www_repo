//
//  FourViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-17.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "FourViewController.h"
#import "BusinessUtil.h"

@interface FourViewController () {
    UIButton *btn1, *btn2, *btn3, *btn4, *btn5;
    BOOL isShow;

    UILabel *toastLable;
}

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

    [self initButtons];
}

- (void)initButtons {
    isShow = NO;
    btn1 = [[UIButton alloc]init];
    btn2 = [[UIButton alloc]init];
    btn3 = [[UIButton alloc]init];
    btn4 = [[UIButton alloc]init];
    btn5 = [[UIButton alloc]init];
    [self addBtn:btn1 tag:1 image:@"comment.png"];
    [self addBtn:btn2 tag:2 image:@"computer_monitor.png"];
    [self addBtn:btn3 tag:3 image:@"bag.png"];
    [self addBtn:btn4 tag:4 image:@"base.png"];
    [self addBtn:btn5 tag:5 image:@"credit_card.png"];
}

- (void)addBtn:(UIButton*)btn tag:(int)tag image:(NSString*)name {
    [btn setFrame:CGRectMake(0, 0, 32, 32)];
    btn.tag = tag;
    [btn setCenter:CGPointMake(-16, 360)];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_groupView addSubview:btn];
}

- (void)clickBtn:(UIButton*)btn {
    NSLog(@"-----%ld",btn.tag);
    [self toast:[NSString stringWithFormat:@"Button's tag is %ld",btn.tag] duration:2 parentView:_groupView center:CGPointMake(_groupView.center.x, _groupView.center.y + 20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [btn1 release];
    [btn2 release];
    [btn3 release];
    [btn4 release];
    [btn5 release];
    [_groupView release];
    [super dealloc];
}

- (IBAction)clickBegin:(id)sender {
    if (isShow) {
        isShow = NO;

        btn1.hidden = YES;
        btn2.hidden = YES;
        btn3.hidden = YES;
        btn4.hidden = YES;
        btn5.hidden = YES;
        [btn1 setCenter:CGPointMake(-16, 360)];
        [btn2 setCenter:CGPointMake(-16, 360)];
        [btn3 setCenter:CGPointMake(-16, 360)];
        [btn4 setCenter:CGPointMake(-16, 360)];
        [btn5 setCenter:CGPointMake(-16, 360)];
    } else {
        isShow = YES;

        [self actionAnimation:btn1 toPoint:CGPointMake(200, 95)  controlPoint:CGPointMake(240, 300)];
        [self actionAnimation:btn2 toPoint:CGPointMake(220, 150) controlPoint:CGPointMake(200, 320)];
        [self actionAnimation:btn3 toPoint:CGPointMake(200, 210) controlPoint:CGPointMake(180, 340)];
        [self actionAnimation:btn4 toPoint:CGPointMake(170, 270) controlPoint:CGPointMake(140, 340)];
        [self actionAnimation:btn5 toPoint:CGPointMake(120, 320) controlPoint:CGPointMake(80, 360)];
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [btn1 setCenter:CGPointMake(200, 90)];
    [btn2 setCenter:CGPointMake(220, 150)];
    [btn3 setCenter:CGPointMake(200, 210)];
    [btn4 setCenter:CGPointMake(170, 270)];
    [btn5 setCenter:CGPointMake(120, 320)];
}

- (void)actionAnimation:(UIButton*)btn toPoint:(CGPoint)toP controlPoint:(CGPoint)controlP {
    btn.hidden = NO;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:btn.center];
    [path addQuadCurveToPoint:toP controlPoint:controlP];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.delegate = self;
    animation.duration = 0.6;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [btn.layer addAnimation:animation forKey:nil];

    //透明度变化
    //    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    //    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    //    opacityAnim.toValue = [NSNumber numberWithFloat:0.2];
    //
    //    CAAnimationGroup *animG = [CAAnimationGroup animation];
    //    animG.animations = [NSArray arrayWithObjects:animation, nil];
    //    animG.duration = 0.6;
    //    animG.delegate = self;
    //    animG.removedOnCompletion = NO;
    //    animG.fillMode = kCAFillModeForwards;

    //    [btn1.layer addAnimation:animation1 forKey:@"action"];
}

- (void)toast:(NSString*)msg duration:(CGFloat)time parentView:(UIView*)parent center:(CGPoint)center {
    CGSize widthSize = CGSizeMake(300, 0);
//    CGSize finalSize = [msg sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:widthSize lineBreakMode:NSLineBreakByWordWrapping];
    CGSize finalSize = [msg boundingRectWithSize:widthSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;

    toastLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, finalSize.width, finalSize.height + 10)];
    toastLable.text = msg;
    toastLable.textColor = [UIColor whiteColor];
    toastLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [toastLable.layer setCornerRadius:10];
    [toastLable setCenter:center];

    [parent addSubview:toastLable];

    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(toastTimeOver) userInfo:nil repeats:NO];
}

- (void)toastTimeOver {
    [toastLable removeFromSuperview];
}
@end
