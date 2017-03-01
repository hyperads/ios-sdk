# HTML Banner

The HyperADX allows you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

Please complete the steps mentioned in the [Setup the SDK](../README.md#set-up-the-sdk) section to set up the SDK.

### Swift implementation

1. Open your View Controller. Import the SDK, declare that you implement the `HADBannerAdDelegate` protocol, and add a function that initializes the banner view.

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADBannerAdDelegate
```

```objective-c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADBannerAdDelegate>
```

2. Find the `viewDidLoad` implementation. Add the code below to create a new instance of `HADBannerAd` and add it to the view. `HADBannerAd` is a subclass of `UIView`, you can add it to your view hierarchy just like any other view.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    let bannerView = HADBannerAd(placementID: "PLACEMENT_ID", bannerSize:.banner300x250, viewController: self)
    bannerView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:HADBannerAdSize.getSize(.banner300x250).height)
    bannerView.delegate = self
    bannerView.loadAd()
    view.addSubview(bannerView)
}
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    HADBannerAd *bannerView = [[HADBannerAd alloc] initWithPlacementID:@"PLACEMENT_ID" bannerSize:HADBannerAdSizeBanner300x250 viewController:self];
    adView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    bannerView.delegate = self;
    [bannerView loadAd];
    [self.view addSubview:bannerView];
}
```


Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

```swift
func hadBannerAdDidLoad(bannerAd: HADBannerAd) {
    print("hadBannerAdDidLoad")
}

func hadBannerAdDidClick(bannerAd: HADBannerAd) {
    print("hadBannerAdDidClick")
}

func hadBannerAdWillLogImpression(bannerAd: HADBannerAd) {
    print("hadBannerAdWillLogImpression")
}

func hadBannerAdDidFail(bannerAd: HADBannerAd, withError error: NSError?) {
    print("hadBannerAdDidFail \(error)")
}
```

```objective-c
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

```
