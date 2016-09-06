//
//  BannerHeight90.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "BannerHeight90.h"

@interface BannerHeight90 () <HADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerView *bannerView;
@end

@implementation BannerHeight90

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.bannerView loadAd:@"5b3QbMRQ" bannerSize:HADBannerSizeHeight90 delegate:self];
}

#pragma mark - HADBannerViewDelegate

-(void)HADViewDidLoad:(HADBannerView *)view {
    NSLog(@"HADViewDidLoad");
}

-(void)HADView:(HADBannerView *)view didFailWithError:(NSError *)error {
    NSLog(@"HADViewDidFai:l %@", error);
}

-(void)HADViewDidClick:(HADBannerView *)view {
    NSLog(@"HADViewDidClick");
}

@end
