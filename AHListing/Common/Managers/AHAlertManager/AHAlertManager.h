//
//  AHAlertManager.h
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AHAlertManager : NSObject

+ (void)createAlertWithTitle:(NSString *)title message:(NSString *)message
              viewController:(UIViewController *)controller;
@end
