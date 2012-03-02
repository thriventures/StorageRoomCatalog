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

@property (nonatomic, strong) IBOutlet SRFieldDetailViewController *fieldDetailViewController;
@property (nonatomic, strong) IBOutlet SREntriesViewController *entriesViewController;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) SRCollection *collection;

@end
