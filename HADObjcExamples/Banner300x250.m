//
//  Banner300x250.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "Banner300x250.h"

@interface Banner300x250 () <HADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerView *bannerView;
@end

@implementation Banner300x250

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.bannerView loadAdWithPlacementId:@"5b3QbMRQ" bannerSize:HADBannerSizeBlock300x250 delegate:self];
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
