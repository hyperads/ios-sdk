//
//  NativeAdViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 25/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "NativeAdViewController.h"
#import <HADFramework/HADFramework.h>

@interface NativeAdViewController () <HADNativeAdDelegate>

@property (strong, nonatomic) HADNativeAd *nativeAd;

@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet HADMediaView *mediaView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *ctaButton;
@end

@implementation NativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nativeAd = [[HADNativeAd alloc] initWithPlacementId:@"W03qNzM6"];
    self.nativeAd.delegate = self;
    self.nativeAd.mediaCachePolicy = HADNativeAdsCachePolicyAll;
    [self.nativeAd loadAd];
}

-(void)hadNativeAdDidLoadWithNativeAd:(HADNativeAd *)nativeAd{
    
    if (self.nativeAd != nil) {
        [self.nativeAd unregisterView];
    }
    
    self.nativeAd = nativeAd;
    
    // Wire up UIView with the native ad; the whole UIView will be clickable.
    [self.nativeAd registerViewForInteractionWithAdView:self.adView withViewController:self];
    
    //you can specify clickable views like:
    //self.nativeAd.registerViewForInteraction(adView: self.adView, withViewController: self, withClickableViews: [descLabel, iconImageView, ctaButton])
    
    // Create native UI using the ad metadata.
    
    [self.mediaView setNativeAdWithNativeAd:self.nativeAd];
    
    __weak typeof(self) weakSelf = self;
    [self.nativeAd.icon loadImageAsyncWithBlockWithCompletion:^(NSError * error, UIImage * image) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.iconImageView.image = image;
    }];
    
    [self.titleLabel setText:nativeAd.title];
    [self.descriptionLabel setText:nativeAd.description];
    [self.ctaButton setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    [self.ctaButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

-(void)hadNativeAdDidClickWithNativeAd:(HADNativeAd *)nativeAd{
    NSLog(@"hadNativeAdDidClickWithNativeAd");
}

-(void)hadNativeAdDidFailWithNativeAd:(HADNativeAd *)nativeAd withError:(NSError *)error{
    NSLog(@"hadNativeAdDidFailWithNativeAd %@", error.description);
}

@end
