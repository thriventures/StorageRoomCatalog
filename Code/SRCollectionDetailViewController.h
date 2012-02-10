//
//  SRCollectionDetailViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRFieldDetailViewController;
@class SREntriesViewController;

@interface SRCollectionDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet SRFieldDetailViewController *fieldDetailViewController;
@property (nonatomic, retain) IBOutlet SREntriesViewController *entriesViewController;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) SRCollection *collection;

@end
