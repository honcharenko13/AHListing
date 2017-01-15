//
//  AHRestManager.m
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHRestManager.h"
#import "AHParsedListing.h"
#import "AFNetworking.h"

static NSString const *kAHRestManagerBasicUrl = @"https://openapi.etsy.com/v2/";
static NSString const *kAHRestManagerGetCategoriesListPartUrl = @"taxonomy/categories";
static NSString const *kAHRestManagerGetListingsPartUrl = @"listings/active";
static NSString const *kAHRestManagerApiKey = @"?api_key=l6pdqjuf7hdf97h1yvzadfce";
static NSString const *kAHRestManagerLongNameKeyString = @"long_name";
static NSString const *kAHRestManagerCategoryNameKeyString = @"category_name";

@interface AHRestManager ()

@property (strong, nonatomic) AFHTTPSessionManager *httpSessionManager;

@end

@implementation AHRestManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)getCategoriesListOnSuccess:(BlockSuccess)blockArray onFailure:(BlockError)blockError {
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@", kAHRestManagerBasicUrl,
                           kAHRestManagerGetCategoriesListPartUrl, kAHRestManagerApiKey];
    [[AFHTTPSessionManager manager] GET:stringUrl parameters:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                    NSLog(@"%@", responseObject);
                                    NSMutableArray *categoryList = [NSMutableArray array];
                                    for (NSDictionary *category  in responseObject[@"results"]) {
                                        [categoryList addObject:@{kAHRestManagerLongNameKeyString : category[kAHRestManagerLongNameKeyString],
                                                                  kAHRestManagerCategoryNameKeyString : category[kAHRestManagerCategoryNameKeyString]}];
                                    }
                                    if (blockArray) {
                                        blockArray(categoryList);
                                    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (blockError) {
            blockError(error);
        }
    }];
}

- (void)getListingListWithCategoryName:(NSString *)categoryName keywords:(NSString *)keywords
                                 count:(double)count offset:(double)offset
                             onSuccess:(BlockSuccess)blockArray onFailure:(BlockError)blockError {
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@&category=%@&keywords=%@&limit=%f&offset=%f", kAHRestManagerBasicUrl,
                           kAHRestManagerGetListingsPartUrl, kAHRestManagerApiKey, categoryName, keywords, count, offset];
    [[AFHTTPSessionManager manager] GET:stringUrl parameters:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                    NSMutableArray *listingsArray = [NSMutableArray array];
                                    for (NSDictionary *listing in responseObject[@"results"]) {
                                        AHParsedListing *item = [[AHParsedListing alloc] initWithResponseDictionary:listing];
                                        [listingsArray addObject:item];
                                    }
                                    if (blockArray) {
                                        blockArray(listingsArray);
                                    }
                                    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (blockError) {
            blockError(error);
        }
    }];
    
}

- (void)getImageUrlWithListingId:(NSNumber *)listingId onSuccess:(BlockImageSuccess)blockSuccess
                       onFailure:(BlockError)blockError {
    NSString *stringUrl = [NSString stringWithFormat:@"%@listings/%@/images%@", kAHRestManagerBasicUrl,
                           listingId, kAHRestManagerApiKey];
    [[AFHTTPSessionManager manager] GET:stringUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *imagesArray = responseObject[@"results"];
        NSDictionary *firstImageDictionary = imagesArray[0];
        NSString *thumbnailUrlString = firstImageDictionary[@"url_170x135"];
        NSString *fullUrlString = firstImageDictionary[@"url_fullxfull"];
        if (blockSuccess) {
            blockSuccess(fullUrlString, thumbnailUrlString);
        }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (blockError) {
             blockError(error);
         }
     }];
}

@end
