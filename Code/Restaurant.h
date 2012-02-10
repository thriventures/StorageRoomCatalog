//
//  Restaurant.h
//  iPhoneExampleRestKit
//
//  Created by Sascha Konietzke on 7/11/11.
//  Copyright (c) 2011 Thriventures UG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Restaurant : NSManagedObject <SREntry>

@property (nonatomic, copy) NSString * address;

@property (nonatomic, retain) NSDate * lastVisit;
@property (nonatomic, retain) NSNumber * latitude; // embedded resource parsed as attribute
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, copy) NSString * name;

@property (nonatomic, retain) NSNumber * priceRange;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, retain) NSNumber * vegetarianMenu;

@property (nonatomic, copy) NSString * mImageUrl;
@property (nonatomic, copy) NSString * mPreviewImageUrl;

@property (nonatomic, retain) NSDate * mUpdatedAt;
@property (nonatomic, retain) NSDate * mCreatedAt;
@property (nonatomic, copy) NSString * mUrl;



@end
