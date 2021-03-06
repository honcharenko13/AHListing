//
//  AHLoadedListingCollectionViewCell.m
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHLoadedListingCollectionViewCell.h"
#import "AHParsedListing.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AHRestManager.h"
#import "ListingItem+CoreDataClass.h"

@interface AHLoadedListingCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingNameLabel;

@end

@implementation AHLoadedListingCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.listingImageView.image = [UIImage new];
}

- (void)configureCellWithParsedListing:(AHParsedListing *)listing {
    self.listingNameLabel.text = listing.name;
    [self.listingImageView sd_setImageWithURL:[NSURL URLWithString:listing.imageThumbnailUrl]];
}

- (void)configureCellWithSavedListing:(ListingItem *)listing {
    self.listingNameLabel.text = listing.name;
    [self.listingImageView sd_setImageWithURL:[NSURL URLWithString:listing.thumbnailImageUrl]];
}

@end
