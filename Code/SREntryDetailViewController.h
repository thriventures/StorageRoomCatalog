//
//  SREntryDetailViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SREntryDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SREntry *entry;
@property (nonatomic, retain) SRCollection *collection;


@end
