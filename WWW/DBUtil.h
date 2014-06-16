//
//  DBUtil.h
//  WWW
//
//  Created by XiongJian on 2014/06/04.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtil : NSObject

+ (void)insertUserInfo:(NSString *)userName :(NSString*)psw :(NSString*)attribution :(NSString*)imgPath;
@end
