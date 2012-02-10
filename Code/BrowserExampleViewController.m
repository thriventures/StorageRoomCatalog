//
//  SRCollectionExampleViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//


#import "BrowserExampleViewController.h"

#import "SRCollectionDetailViewController.h"

@implementation BrowserExampleViewController

@synthesize tableView, collectionDetailViewController, collections;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRObjectManager *manager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken ssl:NO];   
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
  
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped)] autorelease];
    
    [self reloadButtonTapped];
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.collections = nil;
    self.collectionDetailViewController = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)reloadButtonTapped {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:SRCollectionsPath() delegate:self];
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
    self.collections = anArray.resources;  
    [self.tableView reloadData];   
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.collections count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    SRCollection *collection = [self.collections objectAtIndex:indexPath.row];
    cell.textLabel.text = collection.name;
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.collectionDetailViewController.view = nil;
    self.collectionDetailViewController.collection = [self.collections objectAtIndex:indexPath.row];        
    [self.navigationController pushViewController:self.collectionDetailViewController animated:YES];

    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
