//
//  ViewController.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <HADInterstitialAdDelegate, HADAdViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HADInterstitialAd *interstitial;
@property (strong, nonatomic) NSArray *sectionNames;
@property (strong, nonatomic) NSArray *sectionRows;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionNames = @[@"Native", @"Interstitial", @"Banners"];
    self.sectionRows = @[@[@"Native Ad", @"Native Ads Templates", @"TableView with Native Ads", @"CollectionView with Native Ads"],@[@"Interstitial"],@[@"Banner Ad Height 50", @"Banner Ad Height 90", @"Banner Ad 300x250", @"TableView with Banner Ads", @"CollectionView with Banner Ads"]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
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
    }else if ([adName isEqualToString:@"Banner Ad Height 50"]){
        [self showBanner:HADAdSizeHeight50Banner];
    }else if ([adName isEqualToString:@"Banner Ad Height 90"]){
        [self showBanner:HADAdSizeHeight90Banner];
    }else if ([adName isEqualToString:@"Banner Ad 300x250"]){
        [self showBanner:HADAdSizeHeight250Rectangle];
    }else{
        [self performSegueWithIdentifier:adName sender:nil];
    }
}

- (void)showInterstitial {
    self.interstitial = [[HADInterstitialAd alloc] initWithPlacementID:@"5b3QbMRQ"];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)showBanner:(HADAdSize)size {
    
    HADAdView *adView = [[HADAdView alloc] initWithPlacementID:@"5b3QbMRQ" adSize:size viewController:self];
    adView.delegate = self;
    [adView loadAd];
    
    //create controller
    UIViewController *adController = [UIViewController new];
    adController.view.backgroundColor = [UIColor lightGrayColor];
    [adController.view addSubview:adView];
    
    //set ad size
    int adHeight;
    
    if(size == HADAdSizeHeight250Rectangle){
        adHeight = 250;
    }else if(size == HADAdSizeHeight50Banner){
        adHeight = 50;
    }else if(size == HADAdSizeHeight90Banner){
        adHeight = 90;
    }

    adView.frame = CGRectMake(0, 100, self.view.frame.size.width, adHeight);
    
    //show controller with ad
    [self.navigationController pushViewController:adController animated:@YES];
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
    [self.interstitial showAdFromRootViewController:self];
}

-(void)hadInterstitialAdDidFailWithInterstitialAd:(HADInterstitialAd *)interstitialAd withError:(NSError *)error{
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

@end
