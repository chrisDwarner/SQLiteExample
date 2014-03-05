//
//  ViewController.m
//  SQLiteExample
//
//  Created by chris warner on 3/4/14.
//  Copyright (c) 2014 conedogers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *_tableViewContents;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // setup a dummy table cell
    _tableViewContents = [NSArray arrayWithObjects:@"item", nil];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_tableViewContents objectAtIndex:indexPath.row];
    return cell;
}

@end
