//
//  BusinessUtil.m
//  WWW
//
//  Created by XiongJian on 2014/06/05.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "BusinessUtil.h"

@implementation BusinessUtil

+ (UIImage*)scaleImageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)saveImageToBox:(UIImage*)image WithName:(NSString*)imageName {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:filePath atomically:NO];
}

#pragma mark - hideTabbarByChangeFrame
+ (void)hideTabbarByChangeFrame:(BOOL)hidden withTabBarView:(UIView*)view {
    NSArray *views = view.subviews;
    [UIView animateWithDuration:0.2 animations:^{
        if (hidden) {
            UIView *view1 = [views objectAtIndex:0];
            CGRect frame = view1.frame;
            frame.size.height = [[UIScreen mainScreen]bounds].size.height;
            view1.frame = frame;

            UIView *view2 = [views objectAtIndex:1];
            frame = view2.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
            view2.frame = frame;

            UIView *view3 = [views objectAtIndex:2];
            frame = view3.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
            view3.frame = frame;
        } else {
            UIView *view1 = [views objectAtIndex:0];
            CGRect frame = view1.frame;
            frame.size.height = [[UIScreen mainScreen]bounds].size.height - 49;
            view1.frame = frame;

            UIView *view2 = [views objectAtIndex:1];
            frame = view2.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height - 49;
            view2.frame = frame;

            UIView *view3 = [views objectAtIndex:2];
            frame = view3.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height - 49;
            view3.frame = frame;
        }
    }];
}
@end
