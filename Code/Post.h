//
//  Post.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/11/11.
//  Copyright 2011 Thriventures. All rights reserved.
//


@interface Post : NSObject <SREntry>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *body;

@end
