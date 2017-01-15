//
//  AHLoadedListViewController.m
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHLoadedListViewController.h"
#import "AHRestManager.h"
#import "AHLoadedListingCollectionViewCell.h"
#import "AHAlertManager.h"

static NSString *kAHLoadedListViewControllerCellIdentifier = @"loadedLIstingCellIdentifier";
static NSString *kAHLoadedListViewControllerAlertTitle = @"Error";

@interface AHLoadedListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *listingsArray;

@end

@implementation AHLoadedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listingsArray = [NSMutableArray array];
    [self loadListingsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listingsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AHLoadedListingCollectionViewCell *cell = [collectionView
                                               dequeueReusableCellWithReuseIdentifier:kAHLoadedListViewControllerCellIdentifier
                                               forIndexPath:indexPath];
    [cell configureCellWithListing:self.listingsArray[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Helpers

- (void)loadListingsFromServer {
    [[AHRestManager sharedInstance] getListingListWithCategoryName:self.categoryName
                                                          keywords:self.keywords
                                                         onSuccess:^(NSArray *responseArray) {
        [self.listingsArray addObjectsFromArray:responseArray];
        [self.collectionView reloadData];
    } onFailure:^(NSError *error) {
        [AHAlertManager createAlertWithTitle:kAHLoadedListViewControllerAlertTitle
                                     message:error.localizedDescription
                              viewController:self];
    }];
    
}

@end
