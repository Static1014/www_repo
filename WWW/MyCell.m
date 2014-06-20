//
//  MyCell.m
//  WWW
//
//  Created by XiongJian on 14-6-20.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil] lastObject];
        [self initView];
    }
    return self;
}

- (void)initView {
    _lable.textColor = [UIColor whiteColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_image release];
    [_lable release];
    [_bg release];
    [super dealloc];
}
@end
