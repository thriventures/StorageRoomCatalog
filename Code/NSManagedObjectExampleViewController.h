//
//  ComplexMappingViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RestaurantDetailViewController;

@interface NSManagedObjectExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (nonatomic, retain) IBOutlet RestaurantDetailViewController *restaurantViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *restaurants;
@property (nonatomic, copy) NSString *nextPageURL;

- (IBAction)reloadButtonTapped;

- (void)reloadTableView;

@end
