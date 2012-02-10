//
//  AssociationsExampleViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsViewController;

@interface AssociationsExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, retain) IBOutlet PostsViewController *postsViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *categories;

- (IBAction)reloadButtonTapped;

- (void)resetTableView;


@end
