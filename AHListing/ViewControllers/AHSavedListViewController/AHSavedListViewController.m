//
//  AHListViewController.m
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHSavedListViewController.h"
#import "AHLoadedListingCollectionViewCell.h"
#import "AHDetailViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "ListingItem+CoreDataClass.h"

static NSString *kAHSavedListViewControllerCellIdentifier = @"savedLIstingCellIdentifier";
static NSString *kAHSavedListViewControllerDetailViewControllerIdentifier = @"DetailViewControllerIdentifier";

@interface AHSavedListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSArray *savedListingsArray;

@end

@implementation AHSavedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.savedListingsArray = [NSArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.savedListingsArray = [ListingItem MR_findAll];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.savedListingsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AHLoadedListingCollectionViewCell *cell = [collectionView
                                               dequeueReusableCellWithReuseIdentifier:kAHSavedListViewControllerCellIdentifier
                                               forIndexPath:indexPath];
    [cell configureCellWithSavedListing:self.savedListingsArray[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AHDetailViewController *controller = [self.storyboard
                                          instantiateViewControllerWithIdentifier:kAHSavedListViewControllerDetailViewControllerIdentifier];
    controller.currentSavedListing = self.savedListingsArray[indexPath.item];
    controller.isSaved = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
