//
//  BannerCollectionViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 27/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "BannerCollectionViewController.h"
#import <HADFramework/HADFramework.h>

@interface BannerCollectionViewController () <HADBannerAdDelegate>

@property (strong, nonatomic) NSMutableArray *alreadyLoadedAdsInRows;

@end

@implementation BannerCollectionViewController

static NSString * const kDefaultCellIdentifier = @"Cell";
static NSString * const kAdCellIdentifier = @"AD";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alreadyLoadedAdsInRows = [NSMutableArray new];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 9 == 0 && indexPath.row != 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAdCellIdentifier forIndexPath:indexPath];
        
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
        return [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row % 9 == 0 && indexPath.row != 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    } else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width*0.25, [UIScreen mainScreen].bounds.size.width*0.25);
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
