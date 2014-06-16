//
//  NSUncaughtExceptionHandler.m
//  WWW
//
//  Created by XiongJian on 14-6-13.
//  Copyright (c) 2014年 tci. All rights reserved.
//


#import "MyUncaughtExceptionHandler.h"

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *name = [exception name];
    NSString *reason = [exception reason];

    NSString *url = [NSString stringWithFormat:@"===================异常崩溃报告===================\ndate:%@\n\nname:%@\n\nreason:%@\n\ncallStackSymbols:\n%@",[NSDate date],name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString *fileName = [NSString stringWithFormat:@"Exception_%@.txt",[NSDate date]];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@implementation MyUncaughtExceptionHandler

+ (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler {
    return NSGetUncaughtExceptionHandler();
}
@end
