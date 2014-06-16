//
//  DBCommon.m
//  WWW
//
//  Created by XiongJian on 2014/06/04.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "DBCommon.h"
#import <sqlite3.h>

@implementation DBCommon
static DBCommon *dbcon = nil;
static NSString *dbFile = @"w.db";
static NSString *dbName = @"w";

+ (id)shared {
    @synchronized(self)
    {
        if (dbcon == nil) {
            dbcon = [[DBCommon alloc]init];
            [self writeDBFileToBox];
        }
    }
    return dbcon;
}

+ (void)writeDBFileToBox {
    NSString *dbFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbFile];

    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]) {
        NSString *dbResource = [[NSBundle mainBundle] pathForResource:dbName ofType:@"db"];
        NSData *db = [NSData dataWithContentsOfFile:dbResource];
        [[NSFileManager defaultManager] createFileAtPath:dbFilePath contents:db attributes:nil];
    }
}

- (NSMutableArray*)selectDB:(NSString *)tableName condition:(NSArray *)condition {
    sqlite3 *db;
    sqlite3_open([[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbFile] UTF8String], &db);

    sqlite3_stmt *statement;
    NSString *sql = nil;
    NSMutableArray *result = [[NSMutableArray alloc]init];

    if ([condition count] == 0) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM %@",tableName];
    } else {
        NSMutableString *conditionStr = [[[NSMutableString alloc]init]autorelease];
        int i = 0;
        for (NSString *temp in condition) {
            if (i == 0) {
                [conditionStr appendFormat:@"%@", temp];
            } else {
                [conditionStr appendFormat:@" AND %@", temp];
            }
            i++;
        }
        sql = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@", tableName, conditionStr];
    }

    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        NSMutableDictionary *row;

        while (sqlite3_step(statement) == SQLITE_ROW) {
            row = [[NSMutableDictionary alloc]init];

            if ([@"USER_INFO" isEqualToString:tableName]) {
                NSNumber *userId = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
                NSString *userName = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                NSString *psw = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                NSString *attribution = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                NSString *imgPath = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 4)];

                [row setObject:userId forKey:@"USER_ID"];
                [row setObject:userName forKey:@"USER_NAME"];
                [row setObject:psw forKey:@"PASSWORD"];
                [row setObject:attribution forKey:@"ATTRIBUTION"];
                [row setObject:imgPath forKey:@"IMG_PATH"];

                [userName release];
                [psw release];
                [attribution release];
                [imgPath release];
            }

            [result addObject:row];
            [row release];
        }
    }

    sqlite3_finalize(statement);
    [sql release];
    sqlite3_close(db);

    return [result autorelease];
}

- (void)insertDB:(NSString *)tableName columnName:(NSArray *)columnName values:(NSArray *)values intFlg:(NSArray*)isInt {
    sqlite3 *db;
    sqlite3_open([[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbFile] UTF8String], &db);

    NSMutableString *columnNameStr = [[NSMutableString alloc]init];
    NSMutableString *valueStr = [[NSMutableString alloc]init];

    int i = 0;
    for (NSString *temp in columnName) {
        if (i == 0) {
            [columnNameStr appendFormat:@" %@",temp];
        } else {
            [columnNameStr appendFormat:@" , %@",temp];
        }
        i++;
    }

    i = 0;
    for (NSString *temp in values) {
        BOOL valueIsInt = NO;
        if ([values count] != 0) {
            if(((NSNumber*)[isInt objectAtIndex:i]).intValue == 1) {
                valueIsInt = YES;
            }
        }

        if (i == 0) {
            [valueStr appendFormat:valueIsInt?@" %@":@" '%@'",temp];
        } else {
            [valueStr appendFormat:valueIsInt?@" , %@":@" , '%@'",temp];
        }
        i++;
    }

    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@( %@ ) VALUES( %@ )",tableName,columnNameStr,valueStr];
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        NSLog(@"error : %s when insert into %@",err,tableName);
    }

    [columnNameStr release];
    [valueStr release];

    sqlite3_close(db);
}

- (void)updateDB:(NSString *)tableName detail:(NSArray *)detail condition:(NSArray *)condition {
    sqlite3 *db;
    sqlite3_open([[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbFile] UTF8String], &db);

    NSMutableString *detailStr = [[NSMutableString alloc]init];
    NSMutableString *conditionStr = [[NSMutableString alloc]init];
    NSString *sql = nil;

    int i = 0;
    for (NSString *temp in detail) {
        if (i == 0) {
            [detailStr appendFormat:@" %@",temp];
        } else {
            [detailStr appendFormat:@" , %@",temp];
        }
        i++;
    }

    if ([condition count] > 0) {
        i = 0;
        for (NSString *temp in condition) {
            if (i == 0) {
                [conditionStr appendFormat:@" %@",temp];
            } else {
                [conditionStr appendFormat:@" AND %@",temp];
            }
            i++;
        }
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,detailStr,conditionStr];
    } else {
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@",tableName,detailStr];
    }

    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        NSLog(@"error : %s when update into %@",err,tableName);
    }

    [detailStr release];
    [conditionStr release];

    sqlite3_close(db);
}

- (void)deleteDB:(NSString *)tableName condition:(NSArray *)condition {
    sqlite3 *db;
    sqlite3_open([[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbFile] UTF8String], &db);

    NSMutableString *conditionStr = [[NSMutableString alloc]init];
    NSString *sql = nil;

    if ([condition count] > 0) {
        int i = 0;
        for (NSString *temp in condition) {
            if (i == 0) {
                [conditionStr appendFormat:@" %@",temp];
            } else {
                [conditionStr appendFormat:@" AND %@",temp];
            }
            i++;
        }
        sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,conditionStr];
    } else {
        sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    }

    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        NSLog(@"error : %s when delete into %@",err,tableName);
    }

    [conditionStr release];
    
    sqlite3_close(db);
}

@end
