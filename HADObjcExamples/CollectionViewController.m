//
//  CollectionViewController.m
//  HADExamples
//
//  Created by Mihael Isaev on 30.09.16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "CollectionViewController.h"
#import "AdCollectionCell.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout, HADBannerViewDelegate>

@end

@implementation CollectionViewController

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 20 == 0) {
        static NSString *cellIdentifier = @"AD";
        ADCollectionCell *cell = (ADCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        [cell.bannerView loadAdWithPlacementId:@"5b3QbMRQ" bannerSize:HADBannerSizeHeight50 delegate:self];
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"Cell";
        return [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    }
}

#pragma mark <UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 20 == 0) {
        return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 50);
    } else {
        return CGSizeMake([[UIScreen mainScreen] bounds].size.width*0.25, [[UIScreen mainScreen] bounds].size.width*0.25);
    }
}

#pragma mark - HADBannerViewDelegate

-(void)HADViewDidLoadWithView:(HADBannerView *)view {
    NSLog(@"HADViewDidLoad");
}

-(void)HADViewWithView:(HADBannerView *)view didFailWithError:(NSError *)error {
    NSLog(@"HADViewDidFai:l %@", error);
}

-(void)HADViewDidClickWithView:(HADBannerView *)view {
    NSLog(@"HADViewDidClick");
}

@end
