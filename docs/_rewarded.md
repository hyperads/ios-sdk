# Video Rewarded ads


The HyperADX allow you to monetize your iOS apps with rewarded ads. This guide explains how to add rewarded video ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

1. Open your View Controller. Import the SDK, declare that you implement the `HADVideoRewardedAdDelegate` protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADVideoRewardedAdDelegate
```

```objective-c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADVideoRewardedAdDelegate>
```

2. Next, implement `viewDidLoad` method and `hadVideoRewardedAdDidLoad`.
For client-side reward notification, you must to set `customerID`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    videoRewardedAd = HADVideoRewardedAd(placementID: "PLACEMENT_ID")
    videoRewardedAd?.delegate = self
    videoRewardedAd?.customerID = "CUSTOMER_ID"
    videoRewardedAd?.loadAd()
}

func hadVideoRewardedAdDidLoad(ad: HADVideoRewardedAd) {
    videoRewardedAd.showAdFromRootViewController(self)
}
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    self.videoRewarded = [[HADVideoRewardedAd alloc] initWithPlacementID:@"PLACEMENT_ID"];
    self.videoRewarded.delegate = self;
    self.videoRewarded.customerID = @"CUSTOMER_ID";
    [self.videoRewarded loadAd];
}

-(void)hadVideoRewardedAdDidLoadWithAd:(HADVideoRewardedAd *)ad{
    [self.videoRewarded showAdFromRootViewController:self];
}
```

Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

For client-side rewards you must implement `hadVideoRewardedAdComplete` method.

```swift
func hadVideoRewardedAdComplete(ad: HADVideoRewardedAd, reward: HADReward) {
print("hadVideoRewardedAdComplete \(String(describing: reward.getLabel())) \(String(describing: reward.getAmount()))")
}
```

```objective-c
-(void)hadVideoRewardedAdComplete(HADVideoRewardedAd *)ad withReward:(HADReward *)reward {
NSLog(@"hadVideoRewardedAdComplete %@", reward.getLabel()); 
}
```


Optionally, you can add the following functions to handle the cases when the ad is shown, is clicked or closed by users:

```swift
func hadVideoRewardedAdDidClick(ad: HADVideoRewardedAd) {
    print("hadVideoInterstitialDidClick")
}

func hadVideoRewardedAdDidClose(ad: HADVideoRewardedAd) {
    print("hadVideoRewardedAdDidClose")
}

func hadVideoRewardedAdWillClose(ad: HADVideoRewardedAd) {
    print("hadVideoRewardedWillClose")
}

func hadVideoRewardedAdDidFail(ad: HADVideoRewardedAd, withError error: NSError?) {
    print("hadVideoRewardedDidFail: \(error)")
}
```

```objective-c

-(void)hadVideoRewardedAdDidFailWithAd:(HADVideoRewardedAd *)ad withError:(NSError *)error{
    NSLog(@"HADVideoRewardedDidFail: %@", error);
}

-(void)hadVideoRewardedAdDidClickWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedDidClick");
}

-(void)hadVideoRewardedAdWillCloseWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedWillClose");
}

-(void)hadVideoRewardedAdDidCloseWithAd:(HADVideoRewardedAd *)ad{
    NSLog(@"HADVideoRewardedDidClose");
}

```
