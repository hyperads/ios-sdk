# Interstitial ads


The HyperADX allow you to monetize your iOS apps with interstitial ads. This guide explains how to add interstitial ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

1. Open your View Controller. Import the SDK, declare that you implement the `HADInterstitialAdDelegate` protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADInterstitialAdDelegate
```

```objective-c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADInterstitialAdDelegate>
```

2. Next, implement `viewDidLoad` method and `interstitialAdDidLoad`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    interstitialAd = HADInterstitialAd(placementID: "PLACEMENT_ID")
    interstitialAd?.delegate = self
    interstitialAd?.loadAd()
}

func hadInterstitialAdDidLoad(interstitialAd: HADInterstitialAd) {
    interstitialAd.showAdFromRootViewController(self)
}
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    HADInterstitialAd *interstitialAd = [[HADInterstitialAd alloc] initWithPlacementID:@"PLACEMENT_ID"];
    interstitialAd.delegate = self;
    [interstitialAd loadAd];
}

-(void)hadInterstitialAdDidLoadWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    [interstitialAd showAdFromRootViewController:self];
}
```

Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

Optionally, you can add the following functions to handle the cases when the ad is shown, is clicked or closed by users:

```swift
func hadInterstitialAdDidClick(interstitialAd: HADInterstitialAd) {
    print("hadInterstitialDidClick")
}

func hadInterstitialAdDidClose(interstitialAd: HADInterstitialAd) {
    print("hadInterstitialAdDidClose")
}

func hadInterstitialAdWillClose(interstitialAd: HADInterstitialAd) {
    print("hadInterstitialWillClose")
}

func hadInterstitialAdDidFail(interstitialAd: HADInterstitialAd, withError error: NSError?) {
    print("hadInterstitialDidFail: \(error)")
}
```

```objective-c
-(void)hadInterstitialAdDidFailWithInterstitialAd:(HADInterstitialAd *)interstitialAd withError:(NSError *)error{
    NSLog(@"HADInterstitialDidFail: %@", error);
}

-(void)hadInterstitialAdDidClickWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    NSLog(@"HADInterstitialDidClick");
}

-(void)hadInterstitialAdWillCloseWithInterstitialAd:(HADInterstitialAd *)interstitialAd{
    NSLog(@"HADInterstitialWillClose");
}
```
