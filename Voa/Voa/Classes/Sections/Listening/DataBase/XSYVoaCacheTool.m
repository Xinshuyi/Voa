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
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_voa(id integer PRIMARY KEY, voaModel blob);"];
//    // 删除记录
//    [_db executeUpdate:@"delete from t_voa;"];
    
    XSYDetailModel *model = [[XSYDetailModel alloc] init];
    model.Title = @"djfjj";
    NSData *voaData = [NSKeyedArchiver archivedDataWithRootObject:model];
    for (int i = 0; i < 210; i++) {
        BOOL res = [_db executeUpdateWithFormat:@"INSERT INTO t_voa(voaModel) VALUES (%@);", voaData];
    }
}

+ (NSArray *)getVoaModelArrayWithParentID:(NSString *)parentID
{
    NSInteger startID;
    NSInteger numParentID = parentID.intValue;
    if (numParentID >= 100) {// 常速
        startID = (numParentID % 100 + 1) * 10 + 100;
    }else{// 慢速
        startID = numParentID * 10;
    }

    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_voa limit %zd, 10;",startID];
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *voaModels = [NSMutableArray array];
    while (set.next) {
        NSData *voaData = [set objectForColumnName:@"voaModel"];
        XSYDetailModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:voaData];
        [voaModels addObject:model];
        NSLog(@"%@",model);
    }
    return voaModels;
}

+ (void)saveVoaModelArrayWithArray:(NSArray *)voaModelArray WithParentID:(NSString *)parentID
{
    
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    NSInteger i = 0;
    for (XSYDetailModel *voaModel in voaModelArray) {
        NSData *voaData = [NSKeyedArchiver archivedDataWithRootObject:voaModel];
        NSInteger startID;
        NSInteger numParentID = voaModel.parentID.intValue;
        if (numParentID >= 100) {
            startID = (numParentID % 100 + 1) * 10 + 100;
        }else{
            startID = numParentID * 10;
        }
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_voa limit %zd, 10;",startID];
//        // 执行SQL
//        FMResultSet *set = [_db executeQuery:sql];
//        // 如果没有的话就insert
//        if (set == nil) {
//            [_db executeUpdateWithFormat:@"INSERT INTO t_voa(voaModel) VALUES (%@);", voaData];
        // 有的话就更新
       BOOL res = [_db executeUpdateWithFormat:@"update t_voa set voaModel = %@ where id =  %ld;",voaData,startID + i];
        i ++;
    }
}


@end
