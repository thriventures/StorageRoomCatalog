//
//  CRUDExampleViewController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface CRUDExampleViewController : UIViewController <RKObjectLoaderDelegate, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIButton *createButton;
@property (nonatomic, retain) IBOutlet UIButton *updateButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UIButton *reloadButton;

@property (nonatomic, retain) IBOutlet UILabel *detailLabel;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@property (nonatomic, retain) Comment *comment;

- (IBAction)createButtonTapped;
- (IBAction)updateButtonTapped;
- (IBAction)deleteButtonTapped;
- (IBAction)reloadButtonTapped;

- (void)refreshView;

@end
