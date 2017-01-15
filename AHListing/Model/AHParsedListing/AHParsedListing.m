//
//  AHParsedListing.m
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHParsedListing.h"

@implementation AHParsedListing

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary {
    self = [super init];
    if (self) {
        self.listingDescription = responseDictionary[@"description"];
        self.name = responseDictionary[@"title"];
        self.price = [NSString stringWithFormat:@"%@ %@", responseDictionary[@"price"],
                      responseDictionary[@"currency_code"]];
        self.listingId = responseDictionary[@"listing_id"];
    }
    return self;
}

@end
