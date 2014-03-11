//
//  Person.h
//  SQLiteExample
//
//  Created by chris warner on 3/11/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, retain) NSNumber *primaryKey;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *phone;
@end
