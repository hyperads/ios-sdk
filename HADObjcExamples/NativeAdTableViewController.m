//
//  NativeTableViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 26/01/2017.
//  Copyright © 2017 Mihael Isaev. All rights reserved.
//

#import "NativeAdTableViewController.h"
#import <HADFramework/HADFramework.h>

@interface NativeAdTableViewController () <HADNativeAdDelegate, HADNativeAdsManagerDelegate>

@property (strong, nonatomic) HADNativeAdsManager *adsManager;
@property (strong, nonatomic) HADNativeAdTableViewCellProvider *ads;
@property (strong, nonatomic) NSMutableArray *tableViewContentArray;

@end

@implementation NativeAdTableViewController

static NSString * const kDefaultCellIdentifier = @"Cell";
static int const kRowStrideForAdCell = 15;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDefaultCellIdentifier];
    [self loadNativeAds];
}

- (NSMutableArray *)tableViewContentArray {
    if (!_tableViewContentArray) {
        _tableViewContentArray = [NSMutableArray array];
        for (int i = 0; i < 120; i++) {
            NSString *displayText = [NSString stringWithFormat:@"TableCell %i", i];
            [_tableViewContentArray addObject:displayText];
        }
    }
    
    return _tableViewContentArray;
}

- (void)loadNativeAds {
    if (!self.adsManager) {
        self.adsManager = [[HADNativeAdsManager alloc] initWithPlacementID:@"W03qNzM6" numAdsRequested:5];
        
        self.adsManager.delegate = self;
        
        // Configure native ad manager to wait to call nativeAdsLoaded until all ad assets are loaded
        self.adsManager.mediaCachePolicy = HADNativeAdsCachePolicyAll;
    }
    
    [self.adsManager loadAds];
}

#pragma mark - HADNativeAdsManagerDelegate

-(void)nativeAdsLoaded{
    NSLog(@"Native ad was loaded, constructing native UI...");
    
    HADNativeAdTableViewCellProvider *cellProvider =
    [[HADNativeAdTableViewCellProvider alloc] initWithManager:self.adsManager forType:HADNativeAdViewTypeHeight300];
    self.ads = cellProvider;
    self.ads.delegate = self;
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

-(void)nativeAdsFailedToLoadWithError:(NSError *)error{
    NSLog(@"Native ad failed to load with error: %@", error);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // In this example the ads are evenly distributed within the table every kRowStrideForAdCell-th cell.
    NSUInteger count = [self.tableViewContentArray count];
    count = [self.ads adjustCountWithCount:count forStride:kRowStrideForAdCell] ?: count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads cellOf:tableView forRowAt:indexPath];
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
        // In this example we need to adjust the index back to the domain of the data.
        indexPath = [self.ads adjustNonAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell] ?: indexPath;
        cell.textLabel.text = [self.tableViewContentArray objectAtIndex:indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The ad cell provider knows the height of ad cells based on its configuration
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads heightOf:tableView forRowAt:indexPath];
    } else {
        return 80;
    }
}

@end
