//
//  AHAlertManager.m
//  AHListing
//
//  Created by Mac on 1/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHAlertManager.h"

static CGFloat kAHAlertManagerAlertDelay = 1.0f;

@implementation AHAlertManager

+ (void)createAlertWithTitle:(NSString *)title message:(NSString *)message
              viewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [controller presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAHAlertManagerAlertDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
    
}

@end
