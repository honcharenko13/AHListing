//
//  AHDetailViewController.h
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHParsedListing;
@class ListingItem;

@interface AHDetailViewController : UIViewController

@property (nonatomic) AHParsedListing *currentParsedListing;
@property (nonatomic) ListingItem *currentSavedListing;
@property (nonatomic) BOOL isSaved;

@end
