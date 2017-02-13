//
//  XSYEssayDataTool.m
//  Voa
//
//  Created by xin on 2017/2/13.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYEssayDataTool.h"
#import <FMDB.h>
#import "XSYEssayMainModel.h"

@implementation XSYEssayDataTool

static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"essay.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_essay(id integer PRIMARY KEY, essayModel blob);"];
    // 删除记录
    //    [_db executeUpdate:@"delete from t_voa;"];
    NSUInteger count = [_db intForQuery:@"select count(*) from t_essay;"];
    
    if (count > 0) return;
    
    XSYEssayMainModel *model = [[XSYEssayMainModel alloc] init];
    //    model.Title = @"djfjj";
    NSData *essayData = [NSKeyedArchiver archivedDataWithRootObject:model];
    for (int i = 0; i < 10; i++) {
        [_db executeUpdateWithFormat:@"INSERT INTO t_essay(essayModel) VALUES (%@);", essayData];
    }
}

+ (NSArray *)getEssayModelArray
{
    NSString *sql = @"SELECT * FROM t_essay limit 0, 10;";
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *essayModels = [NSMutableArray array];
    while (set.next) {
        NSData *essayData = [set objectForColumnName:@"essayModel"];
        XSYEssayMainModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:essayData];
        [essayModels addObject:model];
        NSLog(@"%@",model);
    }
    return essayModels;
}

+ (void)saveEssayModelArrayWithArray:(NSArray *)essayModelArray
{
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    NSInteger i = 0;
    for (XSYEssayMainModel *essayModel in essayModelArray) {
        NSData *essayData = [NSKeyedArchiver archivedDataWithRootObject:essayModel];
        [_db executeUpdateWithFormat:@"update t_essay set essayModel = %@ where id =  %ld;",essayData,i];
        i ++;
    }
}

@end
