//
//  NSUncaughtExceptionHandler.h
//  WWW
//
//  Created by XiongJian on 14-6-13.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;

@end
