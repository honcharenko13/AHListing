//
//  AHSearchViewController.m
//  AHListing
//
//  Created by Mac on 1/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "AHSearchViewController.h"
#import "AHRestManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AHLoadedListViewController.h"
#import "AHAlertManager.h"

static NSString *kAHSearchViewControllerAlertTitle = @"Error";
static NSString const *kAHSearchViewControllerLongNameKeyString = @"long_name";
static NSString const *kAHSearchViewControllerCategoryNameKeyString = @"category_name";
static NSString *kAHSearchViewControllerLoadedListViewControllerIdentifier = @"AHLoadedListViewControllerIdentifier";
static NSUInteger kAHSearchViewControllerInitialPickerViewIndex = 0;
static NSUInteger kAHSearchViewControllerMinimumSearchBarTextCount = 0;
static NSString *kAHSearchViewControllerSearchBarAlertMessage = @"Please enter keywords";

@interface AHSearchViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic) NSArray *categoriesListArray;
@property (nonatomic) NSString *selectedCategory;

@end

@implementation AHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tapRecognizer];
    self.categoriesListArray = [NSArray array];
    [self loadCategoryListFromServer];
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.categoriesListArray.count;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDictionary *categoryDictionary = self.categoriesListArray[row];
    self.selectedCategory = categoryDictionary[kAHSearchViewControllerCategoryNameKeyString];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *categoryDictionary = self.categoriesListArray[row];
    return (NSString *)categoryDictionary[kAHSearchViewControllerLongNameKeyString];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.submitButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (IBAction)submitButtonWasTapped:(UIButton *)sender {
    if (self.searchBar.text.length > kAHSearchViewControllerMinimumSearchBarTextCount) {
        AHLoadedListViewController *controller = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:
                                                  kAHSearchViewControllerLoadedListViewControllerIdentifier];
        controller.categoryName = self.selectedCategory;
        controller.keywords = self.searchBar.text;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [AHAlertManager createAlertWithTitle:kAHSearchViewControllerAlertTitle
                                     message:kAHSearchViewControllerSearchBarAlertMessage
                              viewController:self];
    }
}

- (void)closeKeyboard {
    [self.searchBar resignFirstResponder];
}

#pragma mark - Helpers

- (void)loadCategoryListFromServer {
    [MBProgressHUD showHUDAddedTo:self.pickerView animated:YES];
    [[AHRestManager sharedInstance] getCategoriesListOnSuccess:^(NSArray *responseArray) {
        self.categoriesListArray = responseArray;
        [MBProgressHUD hideHUDForView:self.pickerView animated:YES];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:kAHSearchViewControllerInitialPickerViewIndex inComponent:0 animated:NO];
        NSDictionary *firstCategory = self.categoriesListArray[kAHSearchViewControllerInitialPickerViewIndex];
        self.selectedCategory = firstCategory[kAHSearchViewControllerCategoryNameKeyString];
        
    } onFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.pickerView animated:YES];
        [AHAlertManager createAlertWithTitle:kAHSearchViewControllerAlertTitle
                                     message:error.localizedDescription
                              viewController:self];
    }];
}

@end
