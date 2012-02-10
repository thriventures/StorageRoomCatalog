//
//  Category.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//


@interface Category : NSObject <SREntry>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mUrl;

@end
