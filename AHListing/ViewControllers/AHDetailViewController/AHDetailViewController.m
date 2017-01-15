//
//  AHDetailViewController.m
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHDetailViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AHParsedListing.h"
#import "ListingItem+CoreDataClass.h"

static NSString *kAHDetailViewControllerDeleteTitleName = @"Delete From Saved";
static NSString *kAHDetailViewControllerTitle = @"Details";

@interface AHDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation AHDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kAHDetailViewControllerTitle;
    [self fillInformation];
    if (self.isSaved) {
        [self.actionButton setTitle:kAHDetailViewControllerDeleteTitleName forState:UIControlStateNormal];
        [self.actionButton setBackgroundColor:[UIColor redColor]];
    }
}

#pragma mark - Helpers

- (void)fillInformation {
    NSURL *imageUrl = self.isSaved ? [NSURL URLWithString:self.currentSavedListing.fullImageUrl] :
    [NSURL URLWithString:self.currentParsedListing.imageFulllUrl];
    [self.imageView sd_setImageWithURL:imageUrl];
    self.nameLabel.text = self.isSaved ? self.currentSavedListing.name : self.currentParsedListing.name;
    self.priceLabel.text = self.isSaved ? self.currentSavedListing.price : self.currentParsedListing.price;
    self.descriptionLabel.text = self.isSaved ? self.currentSavedListing.listingDescription :
                                                self.currentParsedListing.listingDescription;
}

#pragma mark - Helpers

- (IBAction)actionButtonWasTapped:(UIButton *)sender {
    if (self.isSaved) {
        [self.currentSavedListing MR_deleteEntity];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
        ListingItem *listing = [ListingItem MR_createEntity];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
            listing.name = self.currentParsedListing.name;
            listing.listingDescription = self.currentParsedListing.listingDescription;
            listing.price = self.currentParsedListing.price;
            listing.fullImageUrl = self.currentParsedListing.imageFulllUrl;
            listing.thumbnailImageUrl = self.currentParsedListing.imageThumbnailUrl;
            listing.listingId = self.currentParsedListing.listingId.doubleValue;
            [defaultContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
                if (contextDidSave) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }];
    }
}


@end
