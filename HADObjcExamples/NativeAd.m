//
//  NativeAd.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "NativeAd.h"

@interface NativeAd () <HADNativeAdDelegate>
@property (strong, nonatomic) HADNativeAd *nativeAd;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet HADMediaView *bannerMediaView;
@property (weak, nonatomic) IBOutlet HADMediaView *iconMediaView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *ctaButton;
@end

@implementation NativeAd

-(void)viewDidLoad {
    [super viewDidLoad];
    self.nativeAd = [[HADNativeAd alloc] initWithPlacementId:@"5b3QbMRQ" delegate:self];
    [self.nativeAd loadAd];
}

#pragma mark - HADNativeAdDelegate

-(void)HADNativeAdDidLoad:(HADNativeAd *)nativeAd {
    [self.bannerMediaView loadHADBanner:nativeAd animated:NO completion:^(NSError * _Nullable error, UIImage * _Nullable image) {
        if (!error) {
            NSLog(@"Banner downloaded");
        } else {
            NSLog(@"Banner download error: %@", error);
        }
    }];
    [self.iconMediaView loadHADIcon:nativeAd animated:NO completion:^(NSError * _Nullable error, UIImage * _Nullable image) {
        if (!error) {
            NSLog(@"Icon downloaded");
        } else {
            NSLog(@"Icon download error: %@", error);
        }
    }];
    [self.titleLabel setText:nativeAd.title];
    [self.descriptionLabel setText:nativeAd.desc];
    [self.ctaButton setTitle:nativeAd.cta forState:UIControlStateNormal];
}

- (IBAction)handleClick:(id)sender {
    [self.nativeAd handleClick];
}

@end
