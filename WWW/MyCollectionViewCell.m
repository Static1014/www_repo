//
//  MyCollectionViewCell.m
//  WWW
//
//  Created by XiongJian on 14-6-20.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "BusinessUtil.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setCellBg:(UIImage *)bg {
    [_bg setImage:[BusinessUtil scaleImageWithImageSimple:bg scaledToSize:_bg.frame.size]];
}

- (void)setCellImage:(UIImage *)image {
    [_image setImage:[BusinessUtil scaleImageWithImageSimple:image scaledToSize:_image.frame.size]];
}

- (void)setCellText:(NSString *)text {
    _lable.backgroundColor = [UIColor clearColor];
    _lable.numberOfLines = 2;
    _lable.font = [UIFont systemFontOfSize:12];
//    _lable.text = text;

    NSLog(@"%@------%@",text,self.lable.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
