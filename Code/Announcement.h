//
//  Announcement.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//


@interface Announcement : NSObject <SREntry> {

}

@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * link;
@property (nonatomic, strong) SRFile * image;

@property (nonatomic, copy) NSString * mUrl;
@property (nonatomic, strong) NSDate * mUpdatedAt;
@property (nonatomic, strong) NSDate * mCreatedAt;

- (NSString *)toString;

@end
