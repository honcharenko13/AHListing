//
//  AHRestManager.h
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockSuccess)(NSArray *responseArray);
typedef void(^BlockImageSuccess)(NSString *fullUrl, NSString *thumbnailUrl);
typedef void(^BlockError)(NSError *error);

@interface AHRestManager : NSObject

+ (instancetype)sharedInstance;

- (void)getCategoriesListOnSuccess:(BlockSuccess)blockArray onFailure:(BlockError)blockError;
- (void)getListingListWithCategoryName:(NSString *)categoryName keywords:(NSString *)keywords
                                 count:(double)count offset:(double)offset
                             onSuccess:(BlockSuccess)blockArray onFailure:(BlockError)blockError;

@end
