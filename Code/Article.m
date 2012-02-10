//
//  Article.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/12/11.
//  Copyright (c) 2011 Thriventures. All rights reserved.
//

#import "Article.h"


@implementation Article

@dynamic mUrl;
@dynamic text;
@dynamic title;
@dynamic mCreatedAt;
@dynamic mUpdatedAt;

#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class]];
    mapping.primaryKeyAttribute = @"mUrl";
    
    [mapping mapSRAttributes:@"title", @"text", nil];
    [mapping mapSRMetaData:@"url", @"created_at", @"updated_at", nil];
    
    return mapping;
}

+ (NSString *)entryType {
    return @"Article";
}


@end
