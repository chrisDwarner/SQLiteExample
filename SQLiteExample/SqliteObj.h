//
//  SqliteObj.h
//  sqlite-Sample
//
//  Created by chris warner on 12/3/12.
//  Copyright (c) 2012 chris warner. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "sqlite3.h"


@interface SQLiteObject : NSObject {
    sqlite3 *_database;
    NSInteger _primaryKey;
    BOOL      _dirty;
}
@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, readonly) sqlite3 *database;
@property (nonatomic, assign) BOOL dirty;

-(id) init;
-(id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
-(BOOL) isConnected;

+(sqlite3 *) OpenDatabase;
+(void) CloseDatabase:(sqlite3 *)database;
+(NSString *) databasePath;

@end
/*
@interface SqliteObj : NSObject {
    sqlite3 *database;
    NSInteger primaryKey;
    BOOL      dirty;
}

-(id) init;
-(id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
-(BOOL) isConnected;
-(void) deleteWithQuery:(const char *)query;

+(BOOL) prepareSqlite3_stmt:(sqlite3_stmt **)statement database:(sqlite3 *)db sql:(const char *)query;
+(NSString *) pathToDatabase;
+(void) createEditTableCopyOfDatabaseIfNeeded;
+(NSInteger)insertIntoDatabase:(sqlite3 *)database withSql:(const char *)query;
+(NSInteger)getTableCount:(const char *)sql fromDatabase:(sqlite3 *)db;

@end
*/