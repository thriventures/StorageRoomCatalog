//
//  SREntriesViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "SREntriesViewController.h"

#import "SREntryDetailViewController.h"

@implementation SREntriesViewController

@synthesize entryDetailViewController, collection, tableView, entries, nextPageURL;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collection createAndRegisterEntryClass];
    
    [self resetTableView];
    
    self.navigationItem.title = @"Entries";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped)];
    
    [self reloadButtonTapped];    
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.entries = nil;
    self.nextPageURL = nil;
    self.entryDetailViewController = nil;
    self.collection = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)resetTableView {
    self.nextPageURL = nil;    
    self.entries = [NSMutableArray array];

    [self.tableView reloadData];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)reloadButtonTapped {   
    [self resetTableView];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:SRAbsoluteUrlToRelativePath(self.collection.mEntriesUrl) delegate:self];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)requestDidStartLoad:(RKRequest *)request {
    self.navigationItem.rightBarButtonItem.enabled = NO;    
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didLoadObject:(SRArray *)anArray {
    self.nextPageURL = anArray.mNextPageUrl;
    [self.entries addObjectsFromArray:anArray.resources];
    [self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.entries count] + (self.nextPageURL ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if ([self.entries count] == indexPath.row) { // More Cell
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MoreCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCell"];
            cell.textLabel.text = @"More...";
            cell.textLabel.textColor = [UIColor blueColor];
        }        
        
        return cell;
    }
    else { // Entry Cell
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"EntryCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EntryCell"];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
        
        id entry = [self.entries objectAtIndex:indexPath.row];
        NSString *stringValue;
        
        if (self.collection.primaryFieldIdentifier) {
            stringValue = [entry valueForKey:SRIdentifierToObjectiveC(self.collection.primaryFieldIdentifier)];
        }
        else {
            stringValue = [entry identifier];
        }
        
        cell.textLabel.text = stringValue;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.entries count] == indexPath.row) {
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:SRAbsoluteUrlToRelativePath(self.nextPageURL) delegate:self];
    }
    else {
        self.entryDetailViewController.view = nil;
        self.entryDetailViewController.collection = self.collection;
        self.entryDetailViewController.entry = [self.entries objectAtIndex:indexPath.row];        
        [self.navigationController pushViewController:self.entryDetailViewController animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
