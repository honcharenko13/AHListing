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
#import "AHDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

static NSString *kAHLoadedListViewControllerCellIdentifier = @"loadedLIstingCellIdentifier";
static NSString *kAHLoadedListViewControllerAlertTitle = @"Error";
static NSString *kAHLoadedListViewControllerDetailViewControllerIdentifier = @"DetailViewControllerIdentifier";
static double const kAHLoadedListViewControllerDefaultCount = 25;
static double const kAHLoadedListViewControllerDefaultOffset = 0;
static NSUInteger const kAHLoadedListViewControllerDefaultRefreshMinimumIndex = 4;
static NSString *kAHLoadedListViewControllerTitle = @"Loaded";

@interface AHLoadedListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *listingsArray;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation AHLoadedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kAHLoadedListViewControllerTitle;
    self.listingsArray = [NSMutableArray array];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    [self loadListingsFromServerWithCount:kAHLoadedListViewControllerDefaultCount
                                   offset:kAHLoadedListViewControllerDefaultOffset
                                isRefresh:NO];
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
    [cell configureCellWithParsedListing:self.listingsArray[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AHDetailViewController *controller = [self.storyboard
                                          instantiateViewControllerWithIdentifier:kAHLoadedListViewControllerDetailViewControllerIdentifier];
    controller.currentParsedListing = self.listingsArray[indexPath.item];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell
                                                       forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.listingsArray.count - kAHLoadedListViewControllerDefaultRefreshMinimumIndex) {
        [self loadListingsFromServerWithCount:kAHLoadedListViewControllerDefaultCount
                                       offset:self.listingsArray.count isRefresh:NO];
    }
    
}

#pragma mark - Helpers

- (void)loadListingsFromServerWithCount:(double)count offset:(double)offset isRefresh:(BOOL)isRefresh {
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    [[AHRestManager sharedInstance] getListingListWithCategoryName:self.categoryName
                                                          keywords:self.keywords
                                                             count:count
                                                            offset:offset
                                                         onSuccess:^(NSArray *responseArray) {
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
        [self.refreshControl endRefreshing];
        if (isRefresh) {
            self.listingsArray = [NSMutableArray arrayWithArray:responseArray];
        } else {
            [self.listingsArray addObjectsFromArray:responseArray];
        }
        [self.collectionView reloadData];
    } onFailure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
        [AHAlertManager createAlertWithTitle:kAHLoadedListViewControllerAlertTitle
                                     message:error.localizedDescription
                              viewController:self];
    }];
    
}

#pragma mark - Actions

- (void)reloadData {
    [self loadListingsFromServerWithCount:self.listingsArray.count
                                   offset:kAHLoadedListViewControllerDefaultOffset
                                isRefresh:YES];
}

@end
