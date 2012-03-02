//
//  SREntryDetailViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "SREntryDetailViewController.h"

@implementation SREntryDetailViewController

@synthesize entry, collection, tableView;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [entry mUrl];
    
    [self.tableView reloadData];
}


- (void)viewDidUnload {    
    self.tableView = nil;
    self.entry = nil;
    self.collection = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.collection.fields count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MethodCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MethodCell"];
    }
    
    NSString *methodName = [[self.collection.fields objectAtIndex:indexPath.row] identifier];
    cell.textLabel.text = methodName;
    
    id object = [self.entry valueForKey:SRIdentifierToObjectiveC(methodName)];
    NSString *stringValue = [object description];
    cell.detailTextLabel.text = stringValue;
        
    return cell;
    
}


@end
