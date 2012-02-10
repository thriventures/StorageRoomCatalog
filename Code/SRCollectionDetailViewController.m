//
//  SRCollectionDetailViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/8/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "SRCollectionDetailViewController.h"

#import "SRFieldDetailViewController.h"
#import "SREntriesViewController.h"

#define kSectionMain 0
#define kSectionFields 1

#define kRowMainName 0
#define kRowMainEntries 1

@implementation SRCollectionDetailViewController

@synthesize collection, tableView, fieldDetailViewController, entriesViewController;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.collection.name;
    [self.tableView reloadData];
}


- (void)viewDidUnload {    
    self.tableView = nil;
    self.collection = nil;
    self.fieldDetailViewController = nil;
    self.entriesViewController = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case kSectionMain:
            return 2;            
        default:
            return [self.collection.fields count];
    };
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (indexPath.section == kSectionMain) {
        if (indexPath.row == kRowMainName) {
            UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"NameCell"];
            
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NameCell"] autorelease];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
            }
            
            cell.textLabel.text = self.collection.name;
            cell.detailTextLabel.text = self.collection.mUrl;
            cell.detailTextLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
            
            return cell;                 
        }
        else {
            UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"EntriesCell"];
            
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EntriesCell"] autorelease];
                cell.textLabel.text = @"Entries";                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                        
            return cell;     
        }
   
    }
    else {
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"FieldCell"];
        
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FieldCell"] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        SRField *field = [self.collection.fields objectAtIndex:indexPath.row];
        cell.textLabel.text = field.name;
        cell.detailTextLabel.text = field.mType;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kSectionMain && indexPath.row == kRowMainEntries) {
        self.entriesViewController.view = nil;
        self.entriesViewController.collection = self.collection;        
        [self.navigationController pushViewController:self.entriesViewController animated:YES];        
    }
    else if (indexPath.section == kSectionFields) {
        self.fieldDetailViewController.view = nil;
        self.fieldDetailViewController.field = [self.collection.fields objectAtIndex:indexPath.row];        
        [self.navigationController pushViewController:self.fieldDetailViewController animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];        
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == kSectionFields) {
        return @"Fields";
    }
    
    return nil;
}

@end
