//
//  SeededDataExampleViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/12/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeededDataExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *articles;
@property (nonatomic, assign) NSDate *lastSynchronizationDate;

@property (nonatomic, retain) RKObjectLoader *updatedEntriesObjectLoader;
@property (nonatomic, retain) RKObjectLoader *deletedEntriesObjectLoader;

- (IBAction)syncButtonTapped;

- (void)reloadTableView;



@end
