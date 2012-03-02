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

@property (nonatomic, strong) IBOutlet UIButton *createButton;
@property (nonatomic, strong) IBOutlet UIButton *updateButton;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) IBOutlet UIButton *reloadButton;

@property (nonatomic, strong) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic, strong) Comment *comment;

- (IBAction)createButtonTapped;
- (IBAction)updateButtonTapped;
- (IBAction)deleteButtonTapped;
- (IBAction)reloadButtonTapped;

- (void)refreshView;

@end
