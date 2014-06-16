//
//  DBUtil.m
//  WWW
//
//  Created by XiongJian on 2014/06/04.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "DBUtil.h"
#import "DBCommon.h"

@implementation DBUtil

+ (void)insertUserInfo:(NSString *)userName :(NSString*)psw :(NSString*)attribution :(NSString*)imgPath {

    NSMutableArray *names = [[NSMutableArray alloc]init];
    [names addObject:@"USER_NAME"];
    [names addObject:@"PASSWORD"];
    [names addObject:@"ATTRIBUTION"];
    [names addObject:@"IMG_PATH"];
    NSMutableArray *values = [[NSMutableArray alloc]init];
    [values addObject:userName];
    [values addObject:psw];
    [values addObject:attribution];
    [values addObject:imgPath];
    NSMutableArray *isInt = [[NSMutableArray alloc]init];
    [isInt addObject:[NSNumber numberWithInt:0]];
    [isInt addObject:[NSNumber numberWithInt:0]];
    [isInt addObject:[NSNumber numberWithInt:0]];
    [isInt addObject:[NSNumber numberWithInt:0]];

    [[DBCommon shared]insertDB:@"USER_INFO" columnName:names values:values intFlg:isInt];
    [names release];
    [values release];
    [isInt release];
}
@end
