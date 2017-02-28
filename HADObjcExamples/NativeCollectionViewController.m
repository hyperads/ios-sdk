//
//  NativeCollectionViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 26/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "NativeCollectionViewController.h"
#import <HADFramework/HADFramework.h>


@interface NativeCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *textLabel;
@end

@implementation NativeCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 2;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView setBackgroundColor:[UIColor cyanColor]];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
    
}

@end

@interface NativeCollectionViewController () <HADNativeAdDelegate, HADNativeAdsManagerDelegate>

@property (strong, nonatomic) HADNativeAdsManager *adsManager;
@property (strong, nonatomic) HADNativeAdCollectionViewCellProvider *ads;
@property (strong, nonatomic) NSMutableArray *collectionViewContentArray;

@end

@implementation NativeCollectionViewController

static NSString * const kDefaultCellIdentifier = @"Cell";
static int const kRowStrideForAdCell = 37;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[NativeCollectionCell class] forCellWithReuseIdentifier:kDefaultCellIdentifier];
    
    [self loadNativeAds];
}

- (void)loadNativeAds {
    if (!self.adsManager) {
        self.adsManager = [[HADNativeAdsManager alloc] initWithPlacementId:@"W03qNzM6" numAdsRequested:5];
        
        self.adsManager.delegate = self;
        
        // Configure native ad manager to wait to call nativeAdsLoaded until all ad assets are loaded
        //self.adsManager.mediaCachePolicy = HADNativeAdsCachePolicyAll;
    }
    
    [self.adsManager loadAds];
}

- (NSMutableArray *)collectionViewContentArray {
    if (!_collectionViewContentArray) {
        _collectionViewContentArray = [NSMutableArray array];
        for (int i = 0; i < 120; i++) {
            NSString *displayText = [NSString stringWithFormat:@"Cell %i", i];
            [_collectionViewContentArray addObject:displayText];
        }
    }
    
    return _collectionViewContentArray;
}

#pragma mark - HADNativeAdsManagerDelegate

-(void)nativeAdsLoaded{
    NSLog(@"Native ad was loaded, constructing native UI...");
    
    HADNativeAdCollectionViewCellProvider *cellProvider =
    [[HADNativeAdCollectionViewCellProvider alloc] initWithManager:self.adsManager forType:HADNativeAdViewTypeHeight300];
    self.ads = cellProvider;
    self.ads.delegate = self;
    
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = [self.collectionViewContentArray count];
    count = [self.ads adjustCountWithCount:count forStride:kRowStrideForAdCell] ?: count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads cellOf:collectionView forRowAt:indexPath];
    } else {
        NativeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
        // In this example we need to adjust the index back to the domain of the data.
        indexPath = [self.ads adjustNonAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell] ?: indexPath;
        cell.textLabel.text = [self.collectionViewContentArray objectAtIndex:indexPath.row];
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads sizeOf:collectionView forRowAt:indexPath];
    } else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width*0.25, [UIScreen mainScreen].bounds.size.width*0.25);
    }
}

@end
