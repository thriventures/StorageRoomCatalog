//
//  PostsViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/11/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "PostsViewController.h"

#import "Post.h"
#import "Category.h"

#define kPostsUrl SRCollectionEntriesPath(@"4e170ac34d085d091f000105")

@implementation PostsViewController

@synthesize tableView, posts, category;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self resetTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTapped)];
    self.navigationItem.title = self.category.name;
    
    [self reloadButtonTapped];
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.posts = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)resetTableView {
    self.posts = [NSArray array];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)reloadButtonTapped {    
    [self resetTableView];    
    NSString *url = RKPathAppendQueryParams(kPostsUrl, [NSDictionary dictionaryWithObject:self.category.mUrl forKey:@"categories.url"]);
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:url delegate:self];
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
    self.posts = anArray.resources;
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
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CategoryCell"];
        cell.detailTextLabel.numberOfLines = 3;
    }
    
    Post *post = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = post.name;
    cell.detailTextLabel.text = post.body;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
