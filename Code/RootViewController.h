//
//  RootViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/2/11.
//  Copyright 2011 Thriventures. All rights reserved.
//



@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSArray *cellTitles;
@property (nonatomic, retain) NSArray *cellDescriptions;


@end
