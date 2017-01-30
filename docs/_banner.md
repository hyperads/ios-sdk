# Banner

The HyperADX allows you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

Please complete the steps mentioned in the [Setup the SDK](../README.md#set-up-the-sdk) section to set up the SDK.

### Swift implementation

1. Open your View Controller. Import the SDK, declare that you implement the `HADAdViewDelegate` protocol, and add a function that initializes the banner view.

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADAdViewDelegate
```

```objective-c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADAdViewDelegate>
```

2. Find the `viewDidLoad` implementation. Add the code below to create a new instance of `HADAdView` and add it to the view. `HADAdView` is a subclass of `UIView`, you can add it to your view hierarchy just like any other view.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    let bannerView = HADAdView(placementID: "PLACEMENT_ID", adSize:.height50Banner, viewController: self)
    bannerView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:HADAdSize.getSize(.height50Banner).height)
    bannerView.delegate = self
    bannerView.loadAd()
    view.addSubview(bannerView)
}
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    HADAdView *bannerView = [[HADAdView alloc] initWithPlacementID:@"PLACEMENT_ID" adSize:HADAdSizeHeight50Banner viewController:self];
    adView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    bannerView.delegate = self;
    [bannerView loadAd];
    [self.view addSubview:bannerView];
}
```

If you are building your app for iPad, consider using the `HADAdSize.height90Banner` size instead. In all cases, the banner width is flexible with a minimum of 320px.

Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

```swift
func hadViewDidLoad(adView: HADAdView) {
    print("hadViewDidLoad")
}

func hadViewDidClick(adView: HADAdView) {
    print("hadViewDidClick")
}

func hadViewDidFail(adView: HADAdView, withError error: NSError?) {
    print("hadViewDidFail: \(error?.localizedDescription)")
}
```

```objective-c
-(void)hadViewDidLoadWithAdView:(HADAdView *)adView{
    NSLog(@"hadViewDidLoadWithAdView");
}

-(void)hadViewDidClickWithAdView:(HADAdView *)adView{
    NSLog(@"hadViewDidClickWithAdView");
}

-(void)hadViewDidFailWithAdView:(HADAdView *)adView withError:(NSError *)error{
    NSLog(@"hadViewDidFailWithAdView: %@", error);
}
```
