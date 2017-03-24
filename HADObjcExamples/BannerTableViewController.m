//
//  BannerTableViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 27/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "BannerTableViewController.h"
#import <HADFramework/HADFramework.h>

@interface BannerTableViewController () <HADAdViewDelegate>

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
            
            HADAdView *adView = [[HADAdView alloc] initWithPlacementID:@"W03qNzM6" adSize:HADAdSizeHeight50Banner viewController:self];
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

#pragma mark - HADAdViewDelegate

-(void)hadViewDidLoadWithAdView:(HADAdView *)adView{
    NSLog(@"hadViewDidLoadWithAdView");
}

-(void)hadViewDidClickWithAdView:(HADAdView *)adView{
    NSLog(@"hadViewDidClickWithAdView");
}

-(void)hadViewDidFailWithAdView:(HADAdView *)adView withError:(NSError *)error{
    NSLog(@"hadViewDidFailWithAdView: %@", error);
}

@end
