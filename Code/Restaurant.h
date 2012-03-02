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

@property (nonatomic, strong) NSDate * lastVisit;
@property (nonatomic, strong) NSNumber * latitude; // embedded resource parsed as attribute
@property (nonatomic, strong) NSNumber * longitude;
@property (nonatomic, copy) NSString * name;

@property (nonatomic, strong) NSNumber * priceRange;
@property (nonatomic, strong) NSNumber * stars;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) NSNumber * vegetarianMenu;

@property (nonatomic, copy) NSString * mImageUrl;
@property (nonatomic, copy) NSString * mPreviewImageUrl;

@property (nonatomic, strong) NSDate * mUpdatedAt;
@property (nonatomic, strong) NSDate * mCreatedAt;
@property (nonatomic, copy) NSString * mUrl;



@end
