//
//  SeededDataExampleViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/12/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeededDataExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSDate *lastSynchronizationDate;

@property (nonatomic, strong) RKObjectLoader *updatedEntriesObjectLoader;
@property (nonatomic, strong) RKObjectLoader *deletedEntriesObjectLoader;

- (IBAction)syncButtonTapped;

- (void)reloadTableView;



@end
