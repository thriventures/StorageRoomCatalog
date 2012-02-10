//
//  Announcement.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "Announcement.h"


@implementation Announcement

@synthesize text, link, image, mUrl, mCreatedAt, mUpdatedAt;

#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];

    [mapping mapSRAttributes:@"text", @"link", nil];
    [mapping mapSRRelationships:@"image", nil];
    [mapping mapSRMetaData:@"url", @"created_at", @"updated_at", nil]; // this will map m_url to mUrl, m_created_at to mCreatedAt etc.
    
    // The two lines are above are the same as the following code. If you want to map attributes to different names just use customized mappings.
//    [mapping mapKeyPathsToAttributes:@"text", @"text",
//         @"link", @"link",
//         @"m_url", @"mUrl",   
//         @"m_created_at", @"mCreatedAt",
//         @"m_updated_at", @"mUpdatedAt",
//     nil];
      
    return mapping;
}

// This method must return the entryType configured in the Collection.
+ (NSString *)entryType {
    return @"Announcement";
}

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
    self.text = nil;
    self.link = nil;
    self.image = nil;
    self.mUrl = nil;
    self.mCreatedAt = nil;
    self.mUpdatedAt = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Helpers

- (NSString *)toString {
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSString *keyPath in [NSArray arrayWithObjects:@"text", @"link", @"image.mUrl", @"mUrl", @"mCreatedAt", @"mUpdatedAt", nil]) {
        id value = [self valueForKeyPath:keyPath];
        if (value) {
            [attributes addObject:[NSString stringWithFormat:@"%@:\n%@\n", keyPath, value]];            
        }
    }
    
    return [attributes componentsJoinedByString:@"\n"];
}



@end
