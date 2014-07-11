//
//  OneCell.m
//  WWW
//
//  Created by XiongJian on 2014/05/30.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "OneCell.h"
#import "BusinessUtil.h"

@implementation OneCell

- (id)initWithReuseIdentifier:(NSString*)identifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.backgroundColor = [UIColor clearColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    _image = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 36, 36)];
    [self addSubview:_image];
    _lableBg = [[UIImageView alloc]initWithFrame:CGRectMake(50, 3, 260, 44)];
    [self addSubview:_lableBg];
    _textImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 5, 240, 40)];
    [self addSubview:_textImage];
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 240, 40)];
    [self addSubview:_lable];
}

- (void)setCellText:(NSString *)text
{
    _textImage.hidden = YES;

    _lable.text = text;
    _lable.textColor = [UIColor blackColor];
    _lable.backgroundColor = [UIColor clearColor];
    _lable.font = [UIFont systemFontOfSize:14];
    _lable.numberOfLines = 10;

    CGRect frame = [self frame];
    CGSize lableSize;
    if (IOS_VERSION < 7) {
        lableSize = [_lable.text sizeWithFont:_lable.font constrainedToSize:CGSizeMake(240, 300) lineBreakMode:NSLineBreakByWordWrapping];
    } else {
        lableSize = [_lable.text boundingRectWithSize:CGSizeMake(240, 300) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    }
    if (lableSize.height + 10 > 50) {
        frame.size.height = lableSize.height + 10;
        _lable.frame = CGRectMake(60, 5, 240, lableSize.height);
        _image.frame = CGRectMake(7, (frame.size.height - 36)/2, 36, 36);
    } else {
        _lable.frame = CGRectMake(60, 5, lableSize.width, 40);
        frame.size.height = 50;
    }
    self.frame = frame;
}

- (void)textIsImage:(UIImage *)image {
    _lable.hidden = YES;

    CGRect frame = [self frame];
    CGSize textImageSize = CGSizeMake(100, 200);
    if (image.size.width > 100) {
        textImageSize.width = 100;
        textImageSize.height = image.size.height *100/image.size.width;
    } else {
        textImageSize.width = image.size.width;
        textImageSize.height = image.size.height;
    }
    if (textImageSize.height > 200) {
        textImageSize.width = textImageSize.width*200/textImageSize.height;
        textImageSize.height = 200;
    }
    UIImage *newImage = [BusinessUtil scaleImageWithImageSimple:image scaledToSize:textImageSize];
    [_textImage setImage:newImage];

    if (textImageSize.height + 10 > 50) {
        frame.size.height = textImageSize.height + 10;
        _textImage.frame = CGRectMake(60, 5, textImageSize.width, textImageSize.height);
        _image.frame = CGRectMake(7, (frame.size.height - 36)/2, 36, 36);
    } else {
        _textImage.frame = CGRectMake(60, 5, textImageSize.width, textImageSize.height);
        frame.size.height = 50;
    }
    self.frame = frame;
}

- (void)setCellImage:(UIImage*)image
{
    [_image setContentMode:UIViewContentModeScaleToFill];
    _image.frame = CGRectMake(7, 7, 36, 36);
    [_image setImage:image forState:UIControlStateNormal];
    [_image setImage:image forState:UIControlStateHighlighted];
//    [_image setImage:image];
}

- (void)setCellBackgroundImage:(UIImage *)bg
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.frame];
    [bgView setImage:bg];
    [self setBackgroundView:bgView];
    [bgView release];
}

- (void)setTextBackgroundImage:(UIImage *)textBg
{
    CGRect frame = _lable.hidden?_textImage.frame:_lable.frame;
    frame.origin.x -= 10;
    frame.origin.y -= 2;
    frame.size.width += 20;
    frame.size.height += 4;
    [_lableBg setFrame:frame];
    [_lableBg setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
//    [_lableBg setImage:textBg];
    //    _lableBg.hidden = YES;
    [_lableBg.layer setCornerRadius:10];
}

- (void)turnToRight
{
    CGRect frame = _image.frame;
    [_image setFrame:CGRectMake(320 - 50 + 7, frame.origin.y, frame.size.width, frame.size.height)];
    frame = _lableBg.frame;
    [_lableBg setFrame:CGRectMake(320 - 50 - frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
    if (_lable.hidden) {
        frame = _textImage.frame;
        [_textImage setFrame:CGRectMake(_lableBg.frame.origin.x + 10, frame.origin.y, frame.size.width, frame.size.height)];
    } else {
        frame = _lable.frame;
        [_lable setFrame:CGRectMake(_lableBg.frame.origin.x + 10, frame.origin.y, frame.size.width, frame.size.height)];
        [_lableBg setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    }
}

- (void)setImageListener:(id)target action:(SEL)sel events:(UIControlEvents)event {
    [_image addTarget:target action:sel forControlEvents:event];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:YES animated:animated];
}

@end
