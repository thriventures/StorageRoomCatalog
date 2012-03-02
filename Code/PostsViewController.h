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

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) Category *category;

- (IBAction)reloadButtonTapped;

- (void)resetTableView;


@end
