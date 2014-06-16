//
//  OneCell.h
//  WWW
//
//  Created by XiongJian on 2014/05/30.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString*)identifier;

@property (retain, nonatomic) NSIndexPath *indexPath;

@property (retain, nonatomic) UIButton *image;
@property (retain, nonatomic) UILabel *lable;
@property (retain, nonatomic) UIImageView *lableBg;
@property (retain, nonatomic) UIImageView *textImage;

- (void)setCellText:(NSString*)text;
- (void)setCellImage:(UIImage*)image;
- (void)setCellBackgroundImage:(UIImage*)bg;
- (void)setTextBackgroundImage:(UIImage*)textBg;
- (void)textIsImage:(UIImage*)image;
- (void)turnToRight;
@end
