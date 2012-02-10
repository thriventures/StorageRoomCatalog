//
//  Restaurant.m
//  iPhoneExampleRestKit
//
//  Created by Sascha Konietzke on 7/11/11.
//  Copyright (c) 2011 Thriventures UG. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant
@dynamic address;
@dynamic mUrl;
@dynamic mCreatedAt;
@dynamic mImageUrl;
@dynamic lastVisit;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic mPreviewImageUrl;
@dynamic priceRange;
@dynamic stars;
@dynamic text;
@dynamic mUpdatedAt;
@dynamic vegetarianMenu;


#pragma mark -
#pragma mark SREntry Protocol

+ (RKObjectMapping *)objectMapping {
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class]];
    mapping.primaryKeyAttribute = @"mUrl";

    [mapping mapSRAttributes:@"name", @"text", @"address", @"price_range", @"stars", @"vegetarian_menu", @"last_visit",  nil];
    [mapping mapSRMetaData:@"url", @"created_at", @"updated_at", nil];
    
    // map some additional data to custom key paths
    [mapping mapKeyPathsToAttributes:
        @"location.lat", @"latitude",
        @"location.lng", @"longitude",
        @"image.m_url", @"mImageUrl",
        @"preview_image.m_url", @"mPreviewImageUrl",     
     nil];
            
    return mapping;
}

// This method must return the entryType configured in the Collection.
+ (NSString *)entryType {
    return @"Restaurant";
}

@end
