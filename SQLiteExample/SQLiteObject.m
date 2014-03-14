//
//  SqliteObj.m
//  sqlite-Sample
//
//  Created by chris warner on 12/3/12.
//  Copyright (c) 2012 chris warner. All rights reserved.
//
#import "SQLiteManager.h"
#import "SQLiteObject.h"

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
    return [SQLiteManager newConnection];
}

+(void) CloseDatabase:(sqlite3 *)database
{
    [SQLiteManager closeConnection:database];
}

// build an absolute path to the database file.
+(NSString *) databasePath
{
    return [SQLiteManager databasePath];
}


@end
