//
//  StorageRoomCatalogAppDelegate.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/2/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageRoomCatalogAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


- (void)initializeRestKit;
- (void)generateSeedDatabase;


@end
