//
//  SimpleMappingController.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/6/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

 
@interface NSObjectExampleViewController : UIViewController <RKObjectLoaderDelegate>

@property (nonatomic, strong) IBOutlet UILabel *announcementLabel;
@property (nonatomic, strong) IBOutlet UIButton *reloadButton;

- (IBAction)reloadButtonTapped;

@end
