# Video Interstitial ads


The HyperADX allow you to monetize your iOS apps with interstitial ads. This guide explains how to add interstitial ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

1. Open your View Controller. Import the SDK, declare that you implement the `HADVideoInterstitialAdDelegate` protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADVideoInterstitialAdDelegate
```

```objective-c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADVideoInterstitialAdDelegate>
```

2. Next, implement `viewDidLoad` method and `hadVideoInterstitialAdDidLoad`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    videoInterstitialAd = HADVideoInterstitialAd(placementID: "PLACEMENT_ID")
    videoInterstitialAd?.delegate = self
    videoInterstitialAd?.loadAd()
}

func hadVideoInterstitialAdDidLoad(ad: HADVideoInterstitialAd) {
    videoInterstitialAd.showAdFromRootViewController(self)
}
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    self.videoInterstitial = [[HADVideoInterstitialAd alloc] initWithPlacementID:@"PLACEMENT_ID"];
    self.videoInterstitial.delegate = self;
    [self.videoInterstitial loadAd];
}

-(void)hadVideoInterstitialAdDidLoadWithAd:(HADVideoInterstitialAd *)ad{
    [self.videoInterstitial showAdFromRootViewController:self];
}
```

Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

Optionally, you can add the following functions to handle the cases when the ad is shown, is clicked or closed by users:

```swift
func hadVideoInterstitialAdDidClick(ad: HADVideoInterstitialAd) {
    print("hadVideoInterstitialDidClick")
}

func hadVideoInterstitialAdDidClose(ad: HADVideoInterstitialAd) {
    print("hadVideoInterstitialAdDidClose")
}

func hadVideoInterstitialAdWillClose(ad: HADVideoInterstitialAd) {
    print("hadVideoInterstitialWillClose")
}

func hadVideoInterstitialAdDidFail(ad: HADVideoInterstitialAd, withError error: NSError?) {
    print("hadVideoInterstitialDidFail: \(error)")
}
```

```objective-c
-(void)hadVideoInterstitialAdDidFailWithAd:(HADVideoInterstitialAd *)ad withError:(NSError *)error{
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

```
