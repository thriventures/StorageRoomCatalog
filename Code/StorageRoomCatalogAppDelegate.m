//
//  StorageRoomCatalogAppDelegate.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/2/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "StorageRoomCatalogAppDelegate.h"


#import "RootViewController.h"

@implementation StorageRoomCatalogAppDelegate

@synthesize window, navigationController;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
    self.window = nil;
    self.navigationController = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark Helpers

- (void)initializeRestKit {     
    // uncomment the following to enable verbose logging
    
//    RKLogConfigureByName("RestKit", RKLogLevelDebug);
//    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
//    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelDebug);
//    RKLogConfigureByName("RestKit/Network/Queue", RKLogLevelDebug);

    RKLogSetAppLoggingLevel(RKLogLevelDebug);
    
#ifdef RESTKIT_GENERATE_SEED_DB // see the RKCatalog example in the RestKit project
    [self generateSeedDatabase];
#endif
}

// Database seeding is configured as a copied target of the main application. There are only two differences
// between the main application target and the 'Generate Seed Database' target:
//  1) RESTKIT_GENERATE_SEED_DB is defined in the 'Preprocessor Macros' section of the build setting for the target
//      This is what triggers the conditional compilation to cause the seed database to be built
//  2) Source JSON files are added to the 'Generate Seed Database' target to be copied into the bundle. This is required
//      so that the object seeder can find the files when run in the simulator.
- (void)generateSeedDatabase {
	SRObjectManager *objectManager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken];
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:RKDefaultSeedDatabaseFileName usingSeedDatabaseName:nil managedObjectModel:nil delegate:self];
    
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    RKManagedObjectSeeder *seeder = [RKManagedObjectSeeder objectSeederWithObjectManager:objectManager];
    
    [seeder seedObjectsFromFiles:@"articles_export.json", nil];
    
    [seeder finalizeSeedingAndExit];
}

#pragma mark -
#pragma mark UIApplication Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeRestKit];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
