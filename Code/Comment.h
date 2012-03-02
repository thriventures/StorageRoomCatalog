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
@property (nonatomic, strong) NSDate *mCreatedAt;
@property (nonatomic, strong) NSDate *mUpdatedAt;

- (NSString *)toString;

@end
