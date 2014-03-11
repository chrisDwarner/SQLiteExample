//
//  SqliteObj.m
//  sqlite-Sample
//
//  Created by chris warner on 12/3/12.
//  Copyright (c) 2012 chris warner. All rights reserved.
//

#import "SqliteObj.h"

#define DATABASE_NAME @"main.rdb"

@implementation SQLiteObject

@synthesize primaryKey = _primaryKey;
@synthesize database = _database;
@synthesize dirty = _dirty;



-(id) init
{
    if( self = [super init] )
    {
        _primaryKey = 0;
        _database = NULL;
    }
    return self;
}

-(id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db
{
    if( self = [super init] )
    {
        _primaryKey = pk;
        _database = db;
    }
    return self;
}

-(BOOL) isConnected
{
    return (_primaryKey != 0 && _database != NULL);
}

// opens the database.  If the database has not been created, it is created
+(sqlite3 *) OpenDatabase
{
    NSString *dbFilePath = [SQLiteObject databasePath];
    sqlite3 * database = NULL;
    if ( sqlite3_open_v2([dbFilePath UTF8String], &database, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK)
    {
        NSLog(@"Failed to open the database with error %s", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
    
    return database;
}

+(void) CloseDatabase:(sqlite3 *)database
{
    if(database)
    {
        if (sqlite3_close(database) != SQLITE_OK )
        {
            NSLog(@"Failed to close the database with error %s", sqlite3_errmsg(database));
        }
    }
}

// build an absolute path to the database file.
+(NSString *) databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    return path;
}


@end
