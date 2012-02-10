//
//  Comment.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject <SREntry>

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *mUrl;
@property (nonatomic, retain) NSDate *mCreatedAt;
@property (nonatomic, retain) NSDate *mUpdatedAt;

- (NSString *)toString;

@end
