//
//  Comment.m
//  StorageRoomCatalog
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize text, mUrl, mCreatedAt, mUpdatedAt;

#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];

    [mapping mapSRAttributes:@"text", nil];
    [mapping mapSRMetaData:@"url", @"created_at", @"updated_at", nil];
    
    return mapping;
}

+ (NSString *)entryType {
    return @"Comment";
}

// This must be defined when a POST request is created
- (NSString *)mCollectionUrl {
    return SRCollectionPath(@"4e43985f4d085d4dd6000342");
}

#pragma mark -
#pragma mark NSObject


#pragma mark -
#pragma mark Helpers

- (NSString *)toString {
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSString *keyPath in [NSArray arrayWithObjects:@"mUrl", @"text", @"mCreatedAt", @"mUpdatedAt", nil]) {
        id value = [self valueForKeyPath:keyPath];
        if (value) {
            [attributes addObject:[NSString stringWithFormat:@"%@:\n%@\n", keyPath, value]];            
        }
    }
    
    return [attributes componentsJoinedByString:@"\n"];
}


@end
