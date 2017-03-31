//
//  BannerTableViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 27/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "BannerTableViewController.h"
#import <HADFramework/HADFramework.h>

@interface BannerTableViewController () <HADBannerAdDelegate>

@property (strong, nonatomic) NSMutableArray *alreadyLoadedAdsInRows;

@end

@implementation BannerTableViewController

static NSString * const kDefaultCellIdentifier = @"Cell";
static NSString * const kAdCellIdentifier = @"AD";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alreadyLoadedAdsInRows = [NSMutableArray new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 20 == 0 ? 50 : 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 20 == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdCellIdentifier forIndexPath:indexPath];
        
        if (![self.alreadyLoadedAdsInRows containsObject:indexPath]) {
            [self.alreadyLoadedAdsInRows addObject:indexPath];
            
            HADBannerAd *adView = [[HADBannerAd alloc] initWithPlacementID:@"KoMrp58X" bannerSize:HADBannerAdSizeBanner320x50 viewController:self];
            adView.delegate = self;
            [adView loadAd];
            [cell.contentView addSubview:adView];
            adView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
        }
        
        return cell;
    }else{
        return [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
    } 
}

#pragma mark - HADBannerAdDelegate

-(void)hadBannerAdDidLoadWithBannerAd:(HADBannerAd *)bannerAd{
    NSLog(@"hadBannerAdDidLoadWithBannerAd");
}

-(void)hadBannerAdDidClickWithBannerAd:(HADBannerAd *)bannerAd{
    NSLog(@"hadBannerAdDidClickWithBannerAd");
}

-(void)hadBannerAdDidFailWithBannerAd:(HADBannerAd *)bannerAd withError:(NSError *)error{
    NSLog(@"hadBannerAdDidFailWithBannerAd: %@", error);
}

@end
