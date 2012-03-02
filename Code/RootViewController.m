//
//  RootViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 7/12/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "RootViewController.h"

@implementation RootViewController

@synthesize cellTitles, cellDescriptions;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellTitles = [NSArray arrayWithObjects:
                       @"NSObject",
                       @"NSManagedObject",
                       @"Associations",
                       @"CRUD",
                       @"Browser",
                       @"SeededData",
                       nil];
    
    self.cellDescriptions = [NSArray arrayWithObjects:
                             @"Shows the mapping configuration for a plain NSObject.",
                             @"Uses a NSManagedObject as the mapping target. Shows how to do simple pagination.",
                             @"Crawl into nested content through Associations. Load required Entries on demand.",
                             @"CRUD operations. Create an Entry, then update and delete it again.",
                             @"Browse through all your Collections and Entries on StorageRoom.",
                             @"Deliver your application with offline content and do delta synchronization.",
                             nil];
}

- (void)viewDidUnload {
    self.cellTitles = nil;
    self.cellDescriptions = nil;
    
    [super viewDidUnload];
}


#pragma mark -
#pragma mark UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StorageRoomCatalogCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        cell.detailTextLabel.numberOfLines = 2;
    }
    
    cell.textLabel.text = [self.cellTitles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.cellDescriptions objectAtIndex:indexPath.row];    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Clear the singleton instances to isolate the examples
    [SRObjectManager clearEntryObjectMappings];
    [RKClient setSharedClient:nil];    
    [SRObjectManager setSharedManager:nil];

    
    NSString *exampleName = [self.cellTitles objectAtIndex:indexPath.row];
    NSString *fullName = [exampleName stringByAppendingString:@"ExampleViewController"];
    Class exampleClass = NSClassFromString(fullName);
    UIViewController* exampleController = [[exampleClass alloc] initWithNibName:fullName bundle:nil];
    if (exampleController) {
        [self.navigationController pushViewController:exampleController animated:YES];
        if (exampleController.title == nil) {
            exampleController.title = exampleName;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

@end
