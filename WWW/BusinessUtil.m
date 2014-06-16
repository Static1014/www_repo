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
@end
