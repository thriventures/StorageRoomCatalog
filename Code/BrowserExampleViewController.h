//
//  BrowserExampleViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRCollectionDetailViewController;

@interface BrowserExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, retain) IBOutlet SRCollectionDetailViewController *collectionDetailViewController;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *collections;

- (IBAction)reloadButtonTapped;

@end
