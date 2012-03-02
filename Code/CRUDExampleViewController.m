//
//  CRUDExampleViewController.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "CRUDExampleViewController.h"

#import "Comment.h"

@implementation CRUDExampleViewController

@synthesize createButton, updateButton, reloadButton, deleteButton, detailLabel, textField, comment;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRObjectManager *manager = [SRObjectManager objectManagerForAccountId:SRAccountID authenticationToken:SRAuthenticationTokenWithWriteAccess ssl:NO];
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
  
    [self refreshView];
}

- (void)viewDidUnload {
    self.createButton = nil;
    self.updateButton = nil;
    self.reloadButton = nil;    
    self.deleteButton = nil;  
    
    self.detailLabel = nil;
    self.textField = nil;
    
    self.comment = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)refreshView {
    if (self.comment.mCreatedAt) {
        self.createButton.enabled = NO;
        self.updateButton.enabled = YES;
        self.deleteButton.enabled = YES;
        self.reloadButton.enabled = YES;  
        
        self.detailLabel.text = [self.comment toString];
        self.textField.text = self.comment.text;        
    }
    else {
        self.createButton.enabled = YES;
        self.updateButton.enabled = NO;
        self.deleteButton.enabled = NO;
        self.reloadButton.enabled = NO; 
        
        self.detailLabel.text = @"";
        self.textField.text = @"";        
    }
}


#pragma mark -
#pragma mark IBActions

- (IBAction)createButtonTapped {
    self.comment = [[Comment alloc] init];
    self.comment.text = self.textField.text;
    
    [[RKObjectManager sharedManager] postObject:self.comment delegate:self];
}

- (IBAction)updateButtonTapped {
    self.comment.text = self.textField.text;    
    [[RKObjectManager sharedManager] putObject:self.comment delegate:self];    
}

- (IBAction)deleteButtonTapped {
    [[RKObjectManager sharedManager] deleteObject:self.comment delegate:self];    
}

- (IBAction)reloadButtonTapped {
    [[RKObjectManager sharedManager] getObject:self.comment delegate:self];        
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
    [aTextField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)requestDidStartLoad:(RKRequest *)request {
    self.createButton.enabled = NO;
    self.updateButton.enabled = NO;
    self.deleteButton.enabled = NO;
    self.reloadButton.enabled = NO;
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didLoadObject:(Comment *)aComment {
    if ([anObjectLoader.response.request isDELETE] && [anObjectLoader.response isSuccessful]) {
        self.comment = nil;
    }
    else {
        self.comment = aComment;
    }
    
    [self refreshView];
}

- (void)objectLoader:(RKObjectLoader *)anObjectLoader didFailWithError:(NSError *)anError {
    [self refreshView];    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[anError localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

@end
