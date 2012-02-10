//
//  PostsViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/11/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Category;

@interface PostsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *posts;
@property (nonatomic, retain) Category *category;

- (IBAction)reloadButtonTapped;

- (void)resetTableView;


@end
