//
//  SimpleMappingController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/6/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "NSObjectExampleViewController.h"

#import "Announcement.h"

#define kAnnouncementUrl SRCollectionEntryPath(@"4d96091dba0561733300001b", @"4d96091dba05617333000023")

@implementation NSObjectExampleViewController

@synthesize announcementLabel, reloadButton;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SRObjectManager *manager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationToken ssl:NO];
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
}

- (void)viewDidUnload {
    self.announcementLabel = nil;
    self.reloadButton = nil;
        
    [super viewDidUnload];
}


#pragma mark -
#pragma mark IBActions

- (IBAction)reloadButtonTapped {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:kAnnouncementUrl delegate:self];    
}

#pragma mark RKObjectLoaderDelegate methods

- (void)requestDidStartLoad:(RKRequest *)request {
    self.reloadButton.enabled = NO;
    self.announcementLabel.text = @"Loading...";
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.reloadButton.enabled = YES;    
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didLoadObject:(Announcement *)anAnnouncement {
    self.announcementLabel.text = [anAnnouncement toString];
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
    self.announcementLabel.text = @"";        
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}


@end
