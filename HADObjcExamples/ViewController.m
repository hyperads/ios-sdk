//
//  ViewController.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <HADInterstitialDelegate>
@property (strong, nonatomic) HADInterstitial *interstitial;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createInterstitialController:(id)sender {
    self.interstitial = [[HADInterstitial alloc] initWithPlacementId:@"5b3QbMRQ"];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

#pragma mark - HADInterstitialDelegate

-(void)HADInterstitialDidLoad:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidLoad");
    self.interstitial.modalPresentationStyle = UIModalPresentationFullScreen;
    self.interstitial.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.interstitial animated:YES completion:nil];
}

-(void)HADInterstitialDidFail:(HADInterstitial *)controller error:(NSError *)error {
    NSLog(@"HADInterstitialDidFail: %@", error);
}

-(void)HADInterstitialDidClick:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidClick");
}

-(void)HADInterstitialWillClose:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialWillClose");
}

-(void)HADInterstitialDidClose:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidClose");
}

@end
