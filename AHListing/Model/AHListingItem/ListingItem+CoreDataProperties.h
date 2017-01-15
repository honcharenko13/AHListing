//
//  ListingItem+CoreDataProperties.h
//  
//
//  Created by Mac on 1/15/17.
//
//  This file was automatically generated and should not be edited.
//

#import "ListingItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListingItem (CoreDataProperties)

+ (NSFetchRequest<ListingItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *thumbnailImageUrl;
@property (nullable, nonatomic, copy) NSString *listingDescription;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *fullImageUrl;
@property (nonatomic) double listingId;

@end

NS_ASSUME_NONNULL_END
