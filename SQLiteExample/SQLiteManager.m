//
//  SQLiteManager.m
//  SQLiteExample
//
//  Created by chris warner on 3/14/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//
#import "SQLiteObject.h"
#import "SQLiteManager.h"

@implementation SQLiteManager

+(void) initializeDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [SQLiteObject databasePath];
    
    // if the path does not exist, then we need to initialize the database.
    if ([fileManager fileExistsAtPath:path] == NO)
    {
        sqlite3 *database = NULL;
        // the database file does not exist, so we need to create one.
        if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
        {
            // now we have initialized the database, but we have no database defined yet.
            // From here we drop into SQL and we can create the table that will hold
            // the data that will be displayed in the table view.
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sql"];

            if ([fileManager fileExistsAtPath:filePath]) {
                
                // load the SQL commands that will create the database
                NSString *sqlCommands = [NSString stringWithContentsOfFile:filePath
                                                                  encoding:NSASCIIStringEncoding
                                                                     error:NULL];
                // any error message that sent back from sqlite when creating the database will go here.
                char *szErrorMessage = NULL;
                
                // execute the sql commands
                int error = sqlite3_exec(database, [sqlCommands UTF8String], NULL, NULL, &szErrorMessage);
                
                if (error == SQLITE_OK)
                {
                    NSLog(@"successfully created database");
                }
            }

            sqlite3_close(database);
            database = NULL;
        }
    }
}

+(NSString *) databasePath
{
    return  [SQLiteObject databasePath];
}

+(sqlite3 *) newConnectionFromFilename:(NSString *)databaseFilePath
{
    return NULL;
}

@end
