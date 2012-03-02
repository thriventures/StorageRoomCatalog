//
//  Category.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize name, mUrl;

#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    
    [mapping mapSRAttributes:@"name", nil];
    [mapping mapSRMetaData:@"url", nil];
    
    return mapping;
}

+ (NSString *)entryType {
    return @"Category";
}


@end
