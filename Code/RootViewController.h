//
//  RootViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/2/11.
//  Copyright 2011 Thriventures. All rights reserved.
//



@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSArray *cellTitles;
@property (nonatomic, strong) NSArray *cellDescriptions;


@end
