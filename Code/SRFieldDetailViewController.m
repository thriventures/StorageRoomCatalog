//
//  SRFieldDetailViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "SRFieldDetailViewController.h"

@implementation SRFieldDetailViewController

@synthesize tableView, field, methodNames;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Field: %@", self.field.name];
    
    self.methodNames = [[self.field class] propertyNames];
    
    [self.tableView reloadData];
}

- (void)viewDidUnload {    
    self.tableView = nil;
    self.field = nil;
    self.methodNames = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.methodNames count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MethodCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MethodCell"];
    }
    
    NSString *methodName = [self.methodNames objectAtIndex:indexPath.row];
    cell.textLabel.text = methodName;
    
    id object = [field valueForKey:methodName];
    cell.detailTextLabel.text = [object description];
    
    return cell;
    
}


@end
