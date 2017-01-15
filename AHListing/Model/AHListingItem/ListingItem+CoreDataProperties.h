//
//  ListingItem+CoreDataProperties.h
//  
//
//  Created by Mac on 1/14/17.
//
//  This file was automatically generated and should not be edited.
//

#import "ListingItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListingItem (CoreDataProperties)

+ (NSFetchRequest<ListingItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *listingDescription;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
