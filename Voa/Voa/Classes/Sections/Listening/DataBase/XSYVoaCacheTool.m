//
//  XSYVoaCacheTool.m
//  Voa
//
//  Created by xin on 2017/2/10.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVoaCacheTool.h"
#import "FMDB.h"
#import "XSYDetailModel.h"

@implementation XSYVoaCacheTool

static FMDatabase *_db;
+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"voa.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_voa(id integer PRIMARY KEY, voaModel blob NOT NULL);"];
}

+ (NSArray *)getVoaModelArray
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = @"SELECT * FROM t_voa WHERE id <= 10;";
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *voaModels = [NSMutableArray array];
    while (set.next) {
        NSData *voaData = [set objectForColumnName:@"voaModel"];
        XSYDetailModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:voaData];
        [voaModels addObject:model];
    }
    return voaModels;
}

+ (void)saveVoaModelArray:(NSArray *)voaModelArray
{
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    for (XSYDetailModel *voaModel in voaModelArray) {
        NSData *voaData = [NSKeyedArchiver archivedDataWithRootObject:voaModel];
        [_db executeUpdateWithFormat:@"INSERT INTO t_voa(voaModel) VALUES (%@);", voaData];
    }
}


@end
