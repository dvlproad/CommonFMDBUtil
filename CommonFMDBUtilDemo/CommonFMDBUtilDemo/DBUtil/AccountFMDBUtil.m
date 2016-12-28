//
//  AccountFMDBUtil.m
//  LoginDemo
//
//  Created by lichq on 6/26/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "AccountFMDBUtil.h"

static NSString *kCurrentTableName = @"ACCOUNT";

@implementation AccountFMDBUtil

/*
+ (BOOL)createTable
{
    NSString *sql = @"create table if not exists ACCOUNT (uid Text PRIMARY KEY, name TEXT, email TEXT, pasd TEXT, imageName Text, imageUrl Text, imagePath Text, modified TEXT, execTypeL Text);";
    
    return [CommonFMDBUtil create:sql];
}
*/

#pragma mark - insert

+ (BOOL)insertInfo:(AccountInfo *)info
{
    NSAssert(info, @"info cannot be nil!");
    
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT OR REPLACE INTO %@ (uid, name, email, pasd, imageName, imageUrl, imagePath, modified, execTypeL) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", kCurrentTableName, info.uid, info.name, info.email, info.pasd, info.imageName, info.imageUrl, info.imagePath, info.modified, info.execTypeL];//DB Error: 1 "unrecognized token: ":"" 即要求插入的字符串需加引号'，而对于表名，属性名，可以不用像原来那样添加。
    
    return [CommonFMDBUtil insert:sql];
}

#pragma mark - remove

+ (BOOL)removeInfoWhereName:(NSString *)name
{
    NSAssert(name, @"name cannot be nil!");
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where name = '%@'",kCurrentTableName, name];
    
    return [CommonFMDBUtil remove:sql];
}

#pragma mark - update

+ (BOOL)updateInfoExceptUID:(AccountInfo *)info whereUID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:
                           @"UPDATE %@ SET name = '%@', email = '%@', pasd = '%@', imageName = '%@', imageUrl = '%@', imagePath = '%@' WHERE uid = '%@'", kCurrentTableName,
                     info.name, info.email, info.pasd, info.imageName, info.imageUrl, info.imagePath, uid];
    return [CommonFMDBUtil update:sql];
}

+ (BOOL)updateInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                      @"update %@ set imagePath = '%@' where uid = '%@'", kCurrentTableName, imagePath, uid];
    return [CommonFMDBUtil update:sql];
}


+ (BOOL)updateInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set imageUrl = '%@' where uid = '%@'", kCurrentTableName, imageUrl, uid];
    return [CommonFMDBUtil update:sql];
}

+ (BOOL)updateInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set execTypeL = '%@' where uid = '%@'", kCurrentTableName, execTypeL, uid];
    return [CommonFMDBUtil update:sql];
}

#pragma mark - query

+ (NSDictionary *)selectInfoWhereUID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where uid = '%@'", kCurrentTableName, uid];
    
    NSArray *result = [CommonFMDBUtil query:sql];
    return result.count > 0 ? result[0] : nil;
}

//为了在登录页面上，输入名字的时候可以显示出已经登录过的头像而加入的方法
+ (UIImage *)selectImageWhereName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT imagePath FROM %@ where name = '%@'", kCurrentTableName, name];
    
    NSArray *result = [CommonFMDBUtil query:sql];
    NSString *imagePath = result.count > 0 ?
            [result[0] objectForKey:@"imagePath"] : [[NSBundle mainBundle] pathForResource:@"people_logout" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}



@end