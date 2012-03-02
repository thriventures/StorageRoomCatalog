//
//  SREntriesViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SREntryDetailViewController;

@interface SREntriesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, strong) IBOutlet SREntryDetailViewController *entryDetailViewController;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) SRCollection *collection;
@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, copy) NSString *nextPageURL;

- (IBAction)reloadButtonTapped;
- (void)resetTableView;

@end
