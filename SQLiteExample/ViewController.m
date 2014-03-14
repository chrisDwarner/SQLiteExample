//
//  ViewController.m
//  SQLiteExample
//
//  Created by chris warner on 3/4/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteObject.h"
#import "Person.h"
#include "sqlite3.h"


@interface ViewController ()
{
    // this is the pointer to the opened database.
    sqlite3 *database;
    
    // TODO:  we want to fill this NSArray with data retrieved from the SQL database.
    NSArray *_tableViewContents;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // setup a dummy table cell.  If we fail to load the database, you
    // will only see one record.
    _tableViewContents = [NSArray arrayWithObjects:@"item", nil];
    
    NSString *databasePath = [SQLiteObject databasePath];
    
    if ( sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // now we have opened the database, retrieve some records.
        sqlite3_stmt *statement = NULL;
        
        // execute the Sql statement
        int error = sqlite3_prepare_v2(database, "SELECT idx, firstname, lastname, phone FROM Contacts", -1, &statement, NULL);

        if (error == SQLITE_OK)
        {
            // got some results, now parse the records returned.
            NSMutableArray *results = [[NSMutableArray alloc] init];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // get the primary key
                int primaryKey = sqlite3_column_int(statement, 0);
                
                // get the data
                NSString *firstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *lastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                // insert into an object
                Person *contact = [[Person alloc] init];
                if (contact) {
                    contact.primaryKey = [NSNumber numberWithInt:primaryKey];
                    contact.firstName = firstName;
                    contact.lastName = lastName;
                    contact.phone = phone;
                    
                    [results addObject:contact];
                }
                
            }
            // store the results for viewing in the tableview.
            _tableViewContents = results;
        }
        
        // clean up the SQL statement when your done.
        sqlite3_finalize(statement);
        
        // close the database pointer.
        sqlite3_close(database);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableViewContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Person *contact = (Person *)[_tableViewContents objectAtIndex:indexPath.row];
    
    if (contact && [contact isKindOfClass:[Person class]])
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
        cell.detailTextLabel.text = contact.phone;
    }
    else
    {
        // no data in the database, use the old string instead.
        cell.textLabel.text = [_tableViewContents objectAtIndex:indexPath.row];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

// this handles the tapping of the detail disclosure button on the table cell.
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked accessory %ld", (long)indexPath.row);
}
@end
