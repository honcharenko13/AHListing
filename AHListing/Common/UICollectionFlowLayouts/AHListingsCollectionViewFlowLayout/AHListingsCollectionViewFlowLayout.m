//
//  AHListingsCollectionViewFlowLayout.m
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHListingsCollectionViewFlowLayout.h"

static NSUInteger kAHListingsCollectionViewFlowLayoutCountItemsInRow = 3;

@implementation AHListingsCollectionViewFlowLayout

- (CGSize)itemSize {
    NSInteger numberOfColumns = kAHListingsCollectionViewFlowLayoutCountItemsInRow;
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - numberOfColumns) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end
