//
//  NativeTemplateLineThree.m
//  HADExamples
//
//  Created by Mihael Isaev on 15/07/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "NativeTemplateLineThree.h"

@interface NativeTemplateLineThree () <HADBannerTemplateViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerTemplateView *bannerTemplateView;
@end

@implementation NativeTemplateLineThree

-(void)viewDidLoad {
    [super viewDidLoad];
    //Just set HADBannerTemplateTypes param in loadAd method
    [self.bannerTemplateView loadAdWithPlacementId:@"5b3QbMRQ" bannerTemplate:HADBannerTemplateTypesLineThree delegate:self];
    //And customize everything
    [self.bannerTemplateView setCustomBackgroundColor:[UIColor lightGrayColor]];
    [self.bannerTemplateView setCustomTitleTextColor:[UIColor blackColor]];
    [self.bannerTemplateView setCustomDescriptionTextColor:[UIColor darkGrayColor]];
    [self.bannerTemplateView setCustomIconCornerRadius:6.0];
    [self.bannerTemplateView setCustomButtonBackgroundColor:[UIColor clearColor]];
    [self.bannerTemplateView setCustomButtonBorderColor:[UIColor purpleColor]];
    [self.bannerTemplateView setCustomButtonBorderWidth:1.0];
    [self.bannerTemplateView setCustomButtonTitleColor:[UIColor purpleColor]];
    [self.bannerTemplateView setCustomButtonCornerRadius:6.0];
    [self.bannerTemplateView setCustomBannerCornerRadius :6.0];
    [self.bannerTemplateView setCustomAgeRatingCornerRadius:4.0];
    [self.bannerTemplateView setCustomStarRatingFilledColor:[UIColor greenColor]];
    [self.bannerTemplateView setCustomStarRatingEmptyColor:[UIColor purpleColor]];
    [self.bannerTemplateView setCustomStarRatingTextColor:[UIColor purpleColor]];
    [self.bannerTemplateView setCustomClickMode:BannerTemplateCustomClickModesButton];
}

#pragma mark - HADBannerTemplateViewDelegate

-(void)HADTemplateViewDidLoad:(HADBannerView *)view {
    NSLog(@"HADTemplateViewDidLoad");
}

-(void)HADTemplateView:(HADBannerView *)view didFailWithError:(NSError *)error {
    NSLog(@"HADTemplateViewDidFai:l %@", error);
}

-(void)HADTemplateViewDidClick:(HADBannerView *)view {
    NSLog(@"HADTemplateViewDidClick");
}

@end
