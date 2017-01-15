//
//  AHParsedListing.h
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHParsedListing : NSObject

@property (nonatomic) NSString *imageThumbnailUrl;
@property (nonatomic) NSString *imageFulllUrl;
@property (nonatomic) NSString *listingDescription;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *price;
@property (nonatomic) NSNumber *listingId;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary;

@end
