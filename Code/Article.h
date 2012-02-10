//
//  Article.h
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/12/11.
//  Copyright (c) 2011 Thriventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject <SREntry> {
}

@property (nonatomic, copy) NSString * mUrl;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, retain) NSDate * mCreatedAt;
@property (nonatomic, retain) NSDate * mUpdatedAt;

@end
