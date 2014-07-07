//
//  DBCommon.h
//  WWW
//
//  Created by XiongJian on 2014/06/04.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCommon : NSObject

+ (id)shared;
+ (void)createDatabaseAndTables;
- (NSMutableArray*)selectDB:(NSString*)tableName condition:(NSArray*)condition;
- (void)insertDB:(NSString*)tableName columnName:(NSArray*)columnName values:(NSArray*)values intFlg:(NSArray*)isInt;
- (void)updateDB:(NSString*)tableName detail:(NSArray*)detail condition:(NSArray*)condition;
- (void)deleteDB:(NSString*)tableName condition:(NSArray*)condition;

@end
