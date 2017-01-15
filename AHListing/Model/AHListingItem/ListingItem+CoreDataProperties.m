//
//  ListingItem+CoreDataProperties.m
//  
//
//  Created by Mac on 1/15/17.
//
//  This file was automatically generated and should not be edited.
//

#import "ListingItem+CoreDataProperties.h"

@implementation ListingItem (CoreDataProperties)

+ (NSFetchRequest<ListingItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ListingItem"];
}

@dynamic thumbnailImageUrl;
@dynamic listingDescription;
@dynamic name;
@dynamic price;
@dynamic fullImageUrl;
@dynamic listingId;

@end
