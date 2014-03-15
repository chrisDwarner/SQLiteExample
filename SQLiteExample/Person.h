//
//  Person.h
//  SQLiteExample
//
//  Created by chris warner on 3/11/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteObject.h"

// The person object is derived off the SQLiteObject class to allow us to operate
// on the data retrieved by the database.  This object will be used to track the
// data while loaded in the tableView.
@interface Person : SQLiteObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *phone;
@end
