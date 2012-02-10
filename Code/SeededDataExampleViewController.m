//
//  SeededDataExampleViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/12/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "SeededDataExampleViewController.h"

#import "Article.h"


#define kArticleEntriesUrl SRCollectionEntriesPath(@"4e4528c74d085d4db7000f4b")
#define kArticlesDeletedEntriesUrl SRDeletedEntriesForCollection(RKMakeURLPath(SRCollectionPath(@"4e4528c74d085d4db7000f4b")))
#define kLastSynchronizationKey @"lastArticleSynchronizationDate"
#define kExportDate @"2011-08-12 13:57:00 GMT"

@implementation SeededDataExampleViewController

@synthesize tableView, articles, updatedEntriesObjectLoader, deletedEntriesObjectLoader;
@dynamic lastSynchronizationDate;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRObjectManager *objectManager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken ssl:NO];
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"ArticleData.sqlite" usingSeedDatabaseName:RKDefaultSeedDatabaseFileName managedObjectModel:nil delegate:self];
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
  
    [self reloadTableView];
    
    RKLogDebug(@"Last synchonization was at: %@", self.lastSynchronizationDate);
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(syncButtonTapped)] autorelease];
}

- (void)viewDidUnload {
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView = nil;
    self.articles = nil;
    
    self.updatedEntriesObjectLoader = nil;
    self.deletedEntriesObjectLoader = nil;
    
    [super viewDidUnload];  
}

#pragma mark -
#pragma mark Helpers

- (void)reloadTableView {
    self.articles = [Article findAllSortedBy:@"mCreatedAt" ascending:YES];    
    
    [self.tableView reloadData];
}

- (NSDate *)lastSynchronizationDate {
    NSDate *date = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastSynchronizationKey];
    
    if (!date) { // first sync after the export has been generated
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        date = [dateFormatter dateFromString:kExportDate];
    }
        
    return date;
}

- (void)setLastSynchronizationDate:(NSDate *)aDate {
    [[NSUserDefaults standardUserDefaults] setObject:aDate forKey:kLastSynchronizationKey];
    RKLogDebug(@"Updated last synchonization to: %@", aDate);
}

- (void)updateEntries {
    NSDictionary *queryParameters = [NSDictionary dictionaryWithObject:[self.lastSynchronizationDate description] forKey:SRAppendOperator(SRMeta(@"updated_at"), @"gt")]; 
    NSString *url = SRPathAppendQueryParams(kArticleEntriesUrl, queryParameters);
    
    self.updatedEntriesObjectLoader = [[RKObjectManager sharedManager] loadObjectsAtResourcePath:url delegate:self];
}

- (void)deleteEntries {
    NSDictionary *queryParameters = [NSDictionary dictionaryWithObject:[self.lastSynchronizationDate description] forKey:SRAppendOperator(SRMeta(@"deleted_at"), @"gt")]; 
    NSString *url = SRPathAppendQueryParams(kArticlesDeletedEntriesUrl, queryParameters);
        
    self.deletedEntriesObjectLoader = [[RKObjectManager sharedManager] loadObjectsAtResourcePath:url delegate:self];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)syncButtonTapped {
    [self updateEntries];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)requestDidStartLoad:(RKRequest *)request {
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didLoadObject:(SRArray *)anArray {
    if (anObjectLoader == self.deletedEntriesObjectLoader) {
        for (SRDeletedEntry *deletedEntry in [anArray resources]) {
            RKLogDebug(@"Deleting Entry with URL %@ from local data store", deletedEntry.mEntryUrl);
            Article *article = [Article findFirstByAttribute:@"mUrl" withValue:deletedEntry.mEntryUrl];
            [[article managedObjectContext] deleteObject:article];
        }
        
        RKLogDebug(@"Done synchronizing, saving object store.");
        [[RKObjectManager sharedManager].objectStore save];
        self.lastSynchronizationDate = [NSDate date];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else {
        [self deleteEntries];
    }

    [self reloadTableView];
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ArticleCell"] autorelease];
    }
    
    Article *article = [self.articles objectAtIndex:indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.text;
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
