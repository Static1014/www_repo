//
//  BusinessUtil.h
//  WWW
//
//  Created by XiongJian on 2014/06/05.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOS_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#define SCREEN_SIZE [[UIScreen mainScreen]bounds]
#define IPHONE_5 [UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen]currentMode].size):NO

#define rotateDegree(x) M_PI * (x) / 180.0

@interface BusinessUtil : NSObject

+ (UIImage*)scaleImageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)saveImageToBox:(UIImage*)image WithName:(NSString*)imageName;
+ (void)hideTabbarByChangeFrame:(BOOL)hidden withTabBarView:(UIView*)view;
@end
