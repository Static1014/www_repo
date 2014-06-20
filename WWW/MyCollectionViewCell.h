//
//  MyCollectionViewCell.h
//  WWW
//
//  Created by XiongJian on 14-6-20.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *bg;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *lable;

- (void)setCellBg:(UIImage*)bg;
- (void)setCellImage:(UIImage*)image;
- (void)setCellText:(NSString*)text;

@end
