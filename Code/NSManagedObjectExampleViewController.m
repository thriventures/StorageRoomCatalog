//
//  ComplexMappingViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "NSManagedObjectExampleViewController.h"

#import "Restaurant.h"

#import "RestaurantDetailViewController.h"

#define kRestaurantsUrl RKPathAppendQueryParams(SRCollectionEntriesPath(@"4d960916ba05617333000005"), [NSDictionary dictionaryWithObject:@"3" forKey:@"per_page"])


@implementation NSManagedObjectExampleViewController

@synthesize restaurantViewController, tableView, restaurants, nextPageURL;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRObjectManager *objectManager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken ssl:NO];
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"RestaurantData.sqlite" usingSeedDatabaseName:nil managedObjectModel:nil delegate:self];
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
  
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped)] autorelease];
    
    if (![self.restaurants count]) {
        [self reloadButtonTapped];        
    }
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.restaurants = nil;
    self.nextPageURL = nil;
    self.restaurantViewController = nil;
    
    [super viewDidUnload];
}

#pragma mark Helpers

- (void)reloadTableView {
    self.restaurants = [Restaurant allObjects];    
        
    [self.tableView reloadData];
}

#pragma mark IBActions

- (IBAction)reloadButtonTapped {
    self.nextPageURL = nil;    
    [Restaurant truncateAll];
    [[RKObjectManager sharedManager].objectStore save];    
    [self reloadTableView];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:kRestaurantsUrl delegate:self];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)requestDidStartLoad:(RKRequest *)request {
    self.navigationItem.rightBarButtonItem.enabled = NO;    
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didLoadObject:(SRArray *)anArray {
    self.nextPageURL = anArray.mNextPageUrl; // mNextPageUrl will be nil on the last page
    [[RKObjectManager sharedManager].objectStore save];
    [self reloadTableView];    
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

#pragma mark UITableViewDelegate / UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.restaurants count] + (self.nextPageURL ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if ([self.restaurants count] == indexPath.row) { // More Cell
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"MoreCell"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCell"] autorelease];
            cell.textLabel.text = @"More...";
            cell.textLabel.textColor = [UIColor blueColor];
        }        
        
        return cell;
    }
    else { // Restaurant Cell
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantCell"] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
        
        Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
        cell.textLabel.text = restaurant.name;
        cell.detailTextLabel.text = restaurant.text;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.restaurants count] == indexPath.row) {
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:SRAbsoluteUrlToRelativePath(self.nextPageURL) delegate:self];
    }
    else {
        self.restaurantViewController.restaurant = [self.restaurants objectAtIndex:indexPath.row];        
        [self.navigationController pushViewController:self.restaurantViewController animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
