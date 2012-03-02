//
//  Post.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/11/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "Post.h"

@implementation Post

@synthesize name, body;

#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    
    [mapping mapSRAttributes:@"name", @"body", nil];
    
    return mapping;
}

+ (NSString *)entryType {
    return @"Post";
}

@end
