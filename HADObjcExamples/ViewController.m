//
//  ViewController.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <HADBannerAdDelegate, HADVideoInterstitialAdDelegate, HADInterstitialAdDelegate, HADVideoRewardedAdDelegate, HADAdViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *preloaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HADInterstitialAd *interstitial;
@property (strong, nonatomic) HADVideoInterstitialAd *videoInterstitial;
@property (strong, nonatomic) HADVideoRewardedAd *videoRewarded;
@property (strong, nonatomic) NSArray *sectionNames;
@property (strong, nonatomic) NSArray *sectionRows;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preloaderView.hidden = YES;
    
    self.sectionNames = @[@"Native", @"Banners", @"Interstitial"];
    self.sectionRows = @[@[@"Native Ad", @"Native Ads Templates", @"TableView with Native Ads", @"CollectionView with Native Ads"],@[@"Banner 300x250", @"TableView with Banner Ads", @"CollectionView with Banner Ads"],@[@"Interstitial", @"Video Interstitial", @"Video Rewarded"]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    //User's event test
    [HADEventManager.sharedInstance setupWithToken:@"TOKEN"];
    [HADEventManager.sharedInstance sendWithType:HADEventTypeInvite];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionNames[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.sectionRows[section]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.textLabel setText:self.sectionRows[indexPath.section][indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:@YES];
    [self adSelected:self.sectionRows[indexPath.section][indexPath.row]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionNames.count;
}

-(void)adSelected:(NSString *)adName{
    
    if ([adName isEqualToString:@"Native Ad"] || [adName isEqualToString:@"TableView with Native Ads"] || [adName isEqualToString:@"CollectionView with Native Ads"] || [adName isEqualToString:@"Native Ads Templates"]) {
        [self performSegueWithIdentifier:adName sender:nil];
    }else if ([adName isEqualToString:@"Interstitial"]){
        [self showInterstitial];
    }else if ([adName isEqualToString:@"Video Interstitial"]){
        [self showVideoInterstitial];
    }else if ([adName isEqualToString:@"Video Rewarded"]){
        [self showVideoRewarded];
    }else if ([adName isEqualToString:@"Banner 300x250"]){
        [self showBanner:HADBannerAdSizeBanner300x250];
    }else{
        [self performSegueWithIdentifier:adName sender:nil];
    }
}

- (void)showInterstitial {
    self.preloaderView.hidden = NO;
    self.interstitial = [[HADInterstitialAd alloc] initWithPlacementID:@"W93593Xw"];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)showVideoInterstitial {
    self.preloaderView.hidden = NO;
    self.videoInterstitial = [[HADVideoInterstitialAd alloc] initWithPlacementID:@"kvaXVl3r"];
    self.videoInterstitial.delegate = self;
    [self.videoInterstitial loadAd];
}

- (void)showVideoRewarded {
    self.preloaderView.hidden = NO;
    self.videoRewarded = [[HADVideoRewardedAd alloc] initWithPlacementID:@"wa2240ra"];
    self.videoRewarded.customerID = @"CUSTOMER_ID";
    self.videoRewarded.delegate = self;
    [self.videoRewarded loadAd];
}

- (void)showBanner:(HADBannerAdSize)size {
    HADBannerAd *adView = [[HADBannerAd alloc] initWithPlacementID:@"KoMrp58X" bannerSize:size viewController:self];
    adView.delegate = self;
    [adView loadAd];
    
    //create controller
    UIViewController *adController = [UIViewController new];
    adController.view.backgroundColor = [UIColor lightGrayColor];
    [adController.view addSubview:adView];
    
    adView.frame = CGRectMake(0, 100, self.view.frame.size.width, 250);
    
    //show controller with ad
    [self.navigationController pushViewController:adController animated:@YES];
}

#pragma mark - HADBannerAdDelegate

-(void)hadBannerAdDidLoadWithBannerAd:(HADBannerAd *)bannerAd{
    NSLog(@"hadBannerAdDidLoad");
}

-(void)hadBannerAdDidClickWithBannerAd:(HADBannerAd *)bannerAd{
    NSLog(@"hadBannerAdDidClick");
}

-(void)hadBannerAdWillLogImpressionWithBannerAd:(HADBannerAd *)bannerAd{
    NSLog(@"hadBannerAdWillLogImpression");
}

-(void)hadBannerAdDidFailWithBannerAd:(HADBannerAd *)bannerAd withError:(NSError *)error{
    NSLog(@"hadBannerAdDidFail: %@", error);
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

#pragma mark - HADInterstitialAdDelegate

-(void)hadInterstitialAdDidLoadWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    self.preloaderView.hidden = YES;
    [self.interstitial showAdFromRootViewController:self];
}

-(void)hadInterstitialAdDidFailWithInterstitialAd:(HADInterstitialAd *)interstitialAd withError:(NSError *)error{
    self.preloaderView.hidden = YES;
    NSLog(@"HADInterstitialDidFail: %@", error);
}

-(void)hadInterstitialAdDidClickWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    NSLog(@"HADInterstitialDidClick");
}

-(void)hadInterstitialAdWillCloseWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    NSLog(@"HADInterstitialWillClose");
}

-(void)hadInterstitialAdDidCloseWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    NSLog(@"HADInterstitialDidClose");
}

#pragma mark - HADVideoInterstitialAdDelegate

-(void)hadVideoInterstitialAdDidLoadWithAd:(HADVideoInterstitialAd *)ad{
    self.preloaderView.hidden = YES;
    [self.videoInterstitial showAdFromRootViewController:self];
}

-(void)hadVideoInterstitialAdDidFailWithAd:(HADVideoInterstitialAd *)ad withError:(NSError *)error{
    self.preloaderView.hidden = YES;
    NSLog(@"HADVideoInterstitialDidFail: %@", error);
}

-(void)hadVideoInterstitialAdDidClickWithAd:(HADVideoInterstitialAd *)ad{
    NSLog(@"HADVideoInterstitialDidClick");
}

-(void)hadVideoInterstitialAdWillCloseWithAd:(HADVideoInterstitialAd *)ad{
    NSLog(@"HADVideoInterstitialWillClose");
}

-(void)hadVideoInterstitialAdDidCloseWithAd:(HADVideoInterstitialAd *)ad{
    NSLog(@"HADVideoInterstitialDidClose");
}

#pragma mark - HADVideoRewardedAdDelegate

-(void)hadVideoRewardedAdDidLoadWithAd:(HADVideoRewardedAd *)ad{
    [self.videoRewarded showAdFromRootViewController:self];
}

-(void)hadVideoRewardedAdDidClickWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedDidClick");
}

-(void)hadVideoRewardedAdDidCloseWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedAdDidClose");
}

-(void)hadVideoRewardedAdWillCloseWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedAdWillClose");
}

-(void)hadVideoRewardedAdCompleteWithAd:(HADVideoRewardedAd *)ad reward:(HADReward *)reward{
    NSLog(@"HADVideoRewardedAdComplete %@", [reward getLabel]);
}

-(void)hadVideoRewardedAdDidFailWithAd:(HADVideoRewardedAd *)ad withError:(NSError *)error{
    self.preloaderView.hidden = YES;
    NSLog(@"HADVideoRewardedDidFail: %@", error);
}

@end
