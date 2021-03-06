//
//  AHLoadedListingCollectionViewCell.h
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHParsedListing;
@class ListingItem;

@interface AHLoadedListingCollectionViewCell : UICollectionViewCell

- (void)configureCellWithParsedListing:(AHParsedListing *)listing;
- (void)configureCellWithSavedListing:(ListingItem *)listing;

@end
