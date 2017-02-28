//
//  NativeTemplatesTableViewController.m
//  HADExamples
//
//  Created by Alexey Fedotov on 26/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

#import "NativeTemplatesTableViewController.h"
#import <HADFramework/HADFramework.h>

@interface NativeTemplatesTableViewController () <HADNativeAdDelegate>

@property (strong, nonatomic) HADNativeAd *nativeAd;
@property (strong, nonatomic) NSArray *templateNames;
@property HADNativeAdViewType templateType;

@end

@implementation NativeTemplatesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.templateNames = @[@"HADNativeAdViewTypeHeight100",@"HADNativeAdViewTypeHeight120",@"HADNativeAdViewTypeHeight300",@"HADNativeAdViewTypeHeight400"];
    
}

-(void)adSelected:(NSString *)adName{
    if([adName isEqualToString:@"HADNativeAdViewTypeHeight100"]){
        self.templateType = HADNativeAdViewTypeHeight100;
    }else if([adName isEqualToString:@"HADNativeAdViewTypeHeight120"]){
        self.templateType = HADNativeAdViewTypeHeight120;
    }else if([adName isEqualToString:@"HADNativeAdViewTypeHeight300"]){
        self.templateType = HADNativeAdViewTypeHeight300;
    }else if([adName isEqualToString:@"HADNativeAdViewTypeHeight400"]){
        self.templateType = HADNativeAdViewTypeHeight400;
    }
    
    self.nativeAd = [[HADNativeAd alloc] initWithPlacementId:@"5b3QbMRQ"];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd];
}

-(void)hadNativeAdDidLoadWithNativeAd:(HADNativeAd *)nativeAd{
    
    if (self.nativeAd != nil) {
        [self.nativeAd unregisterView];
    }
    
    self.nativeAd = nativeAd;
    
    HADNativeAdViewAttributes *attributes = [[HADNativeAdViewAttributes alloc] init];
    
    attributes.backgroundColor = [UIColor blackColor];
    attributes.buttonColor = [UIColor redColor];
    attributes.buttonTitleColor = [UIColor whiteColor];
    
    HADNativeAdView *adView = [HADNativeAdView nativeAdViewWithNativeAd:nativeAd
                                                             withType:self.templateType withAttributes:attributes];

    
    int height;
    
    if(self.templateType == HADNativeAdViewTypeHeight100){
        height = 100;
    }else if(self.templateType == HADNativeAdViewTypeHeight120){
        height = 120;
    }else if(self.templateType == HADNativeAdViewTypeHeight300){
        height = 300;
    }else if(self.templateType == HADNativeAdViewTypeHeight400){
        height = 400;
    }
    
    CGSize size = self.view.bounds.size;
    adView.frame = CGRectMake(0, 100, size.width, height);
    
    // Register the native ad view and its view controller with the native ad instance
    [self.nativeAd registerViewForInteractionWithAdView:adView withViewController:self];
    
    //create controller
    UIViewController *adController = [UIViewController new];
    adController.view.backgroundColor = [UIColor lightGrayColor];
    [adController.view addSubview:adView];
    
    //show controller with ad
    [self.navigationController pushViewController:adController animated:YES];
}

-(void)hadNativeAdDidClickWithNativeAd:(HADNativeAd *)nativeAd{
    NSLog(@"hadNativeAdDidClickWithNativeAd");
}

-(void)hadNativeAdDidFailWithNativeAd:(HADNativeAd *)nativeAd withError:(NSError *)error{
    NSLog(@"hadNativeAdDidFailWithNativeAd %@", error.description);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.templateNames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.textLabel setText:self.templateNames[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self adSelected:self.templateNames[indexPath.row]];
}

@end
