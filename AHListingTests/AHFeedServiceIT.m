//
//  AHFeedServiceIT.m
//  AHListing
//
//  Created by Mac on 1/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AHTestCase.m"
#import "AHRestManager.h"
#import "OHPathHelpers.h"
#import "AHTestCaseIT.m"

@interface AHFeedServiceIT : AHTestCaseIT

@property (strong, nonatomic) AHRestManager *manager;

@end

@implementation AHFeedServiceIT

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.manager = [AHRestManager sharedInstance];
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

#pragma mark test
- (void)testGetCategories {
    [self stubGetCategories];
    
    [self asyncTest:^(XCTestExpectation *expectation) {
        __weak AHRestManager *weakSelfManager = self.manager;
        [weakSelfManager getCategoriesListOnSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTAssertNotNil(responseArray);
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTFail(@"%@", error);
        }];
    }];
}

- (void)stubGetCategories {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *jsonFeed = OHPathForFile(@"categories.json", [self class]);
        NSDictionary *headers = @{
                                  @"Content-Type" : @"application/json"
                                  };
        return [OHHTTPStubsResponse responseWithFileAtPath:jsonFeed statusCode:200 headers:headers];
    }];
}

- (void)testGetCategoriesErrorInternet {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
        __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getCategoriesListOnSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorNotConnectedToInternet);
        }];
    }];
}

- (void)testGetCategoriesErrorServerNotFound {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorCannotFindHost userInfo:nil];
    __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getCategoriesListOnSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorCannotFindHost);
        }];
    }];
}

- (void)stubGetListings {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *jsonFeed = OHPathForFile(@"listings.json", [self class]);
        NSDictionary *headers = @{
                                  @"Content-Type" : @"application/json"
                                  };
        return [OHHTTPStubsResponse responseWithFileAtPath:jsonFeed statusCode:200 headers:headers];
    }];
}

- (void)testGetListingList {
    [self stubGetListings];
    
    [self asyncTest:^(XCTestExpectation *expectation) {
        __weak AHRestManager *weakSelfManager = self.manager;
        [weakSelfManager getListingListWithCategoryName:@"toys" keywords:@"car" count:25 offset:0 onSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTAssertNotNil(responseArray);
            XCTAssertEqual([responseArray count], 25);
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTFail(@"%@", error);
        }];
    }];
}

- (void)testGetListingListErrorInternet {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
    __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getListingListWithCategoryName:@"toys" keywords:@"car" count:25 offset:0 onSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorNotConnectedToInternet);
        }];
    }];
}

- (void)testGetListingListErrorServerNotFound {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorCannotFindHost userInfo:nil];
    __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getListingListWithCategoryName:@"toys" keywords:@"car" count:25 offset:0 onSuccess:^(NSArray *responseArray) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorCannotFindHost);
        }];
    }];
}

- (void)stubGetListingImages {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *jsonFeed = OHPathForFile(@"listingImages.json", [self class]);
        NSDictionary *headers = @{
                                  @"Content-Type" : @"application/json"
                                  };
        return [OHHTTPStubsResponse responseWithFileAtPath:jsonFeed statusCode:200 headers:headers];
    }];
}

- (void)testGetListingImages {
    [self stubGetListingImages];
    
    [self asyncTest:^(XCTestExpectation *expectation) {
        __weak AHRestManager *weakSelfManager = self.manager;
        [weakSelfManager getImageUrlWithListingId:@(479220803) onSuccess:^(NSString *fullUrl, NSString *thumbnailUrl) {
            [expectation fulfill];
            XCTAssertNotNil(fullUrl);
            XCTAssertNotNil(thumbnailUrl);
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTFail(@"%@", error);
        }];
    }];
}

- (void)testGetListingImagesErrorInternet {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
    __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getImageUrlWithListingId:@(479220803) onSuccess:^(NSString *fullUrl, NSString *thumbnailUrl) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorNotConnectedToInternet);
        }];
    }];
}

- (void)testGetListingImagesErrorServerNotFound {
    [self stubHttpErrorDomain:NSURLErrorDomain code:NSURLErrorCannotFindHost userInfo:nil];
    __weak AHRestManager *weakSelfManager = self.manager;
    [self asyncTest:^(XCTestExpectation *expectation) {
        [weakSelfManager getImageUrlWithListingId:@(479220803) onSuccess:^(NSString *fullUrl, NSString *thumbnailUrl) {
            [expectation fulfill];
            XCTFail(@"this is error");
        } onFailure:^(NSError *error) {
            [expectation fulfill];
            XCTAssertEqualObjects([error domain], NSURLErrorDomain);
            XCTAssertEqual([error code], NSURLErrorCannotFindHost);
        }];
    }];
}

@end
