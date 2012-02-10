//
//  AssociationsExampleViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "AssociationsExampleViewController.h"

#import "PostsViewController.h"

#import "Category.h"

#define kCategoriesUrl RKPathAppendQueryParams(SRCollectionEntriesPath(@"4dff88d74d085d6010000033"), [NSDictionary dictionaryWithObject:@"20" forKey:@"per_page"])

@implementation AssociationsExampleViewController

@synthesize postsViewController, tableView, categories;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRObjectManager *manager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken ssl:NO];
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    [self resetTableView];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped)] autorelease];
    
    [self reloadButtonTapped];
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.categories = nil;
    self.postsViewController = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)resetTableView {
    self.categories = [NSArray array];

    [self.tableView reloadData];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)reloadButtonTapped {
    [self resetTableView];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:kCategoriesUrl delegate:self];
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
    self.categories = anArray.resources;
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
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Category *category = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = category.name;
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.postsViewController.view = nil;
    self.postsViewController.category = [self.categories objectAtIndex:indexPath.row];        
    [self.navigationController pushViewController:self.postsViewController animated:YES];

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
