# Banner

The HyperADX Banner ads allow you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app.
See the [list of available types](../README.md#ad-types) for information of other supported ad formats.

### Set up the SDK

Please complete the steps mentioned in the [Setup the SDK](../README.md#set-up-the-sdk) section to set up the SDK.

### Swift implementation

First of all, in your AppDelegate file, create an instance of HADFramework. Import the SDK:

```swift
import HADFramework
```

And in your application didFinishLaunchingWithOptions method call HAD.create():

```swift
private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    HAD.create()
    return true
}
```

Ok, let's move to your View Controller. Import the SDK, declare that you implement the HADBannerViewDelegate protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADBannerViewDelegate {
    var bannerView: HADBannerView!
}
```

Then, on your View Controller's viewDidLoad implementation, use property of the HADBannerView class and add it to your view. Since HADBannerView is a subclass of UIView, you can add it to your view hierarchy just as with any other view:

```swift
override func viewDidLoad() {
    bannerView = HADBannerView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    view.addSubview(bannerView)
    bannerView.loadAd(placementId: "PLACEMENT_ID", bannerSize: .height50, delegate: self)
}
```

If you are building your app for iPad, consider using the `HADBannerSize.Height90` size instead. The HADFramework also supports the 300x250 ad size. Configure the HADBannerView with the following ad size: `HADBannerSize.Block300x250`:

```swift
override func viewDidLoad() {
    bannerView = HADBannerView(frame: CGRect(x: 10, y: 100, width: 300, height: 250))
    view.addSubview(bannerView)
    bannerView.loadAd(placementId: "PLACEMENT_ID", bannerSize: .block300x250, delegate: self)
}
```

Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

```swift
//MARK: HADBannerViewDelegate

func HADViewDidLoad(view: HADBannerView) {
    print("AD LOADED")
}

func HADViewDidClick(view: HADBannerView) {
    print("CLICKED AD")
}

func HADView(view: HADBannerView, didFailWithError error: NSError?) {
    print("ERROR: %@", error?.localizedDescription)
}
```

### Objective-C implementation

First of all, in your AppDelegate file create an instance of HADFramework. Import the SDK header in AppDelegate.h:

```objective_c
#import <HADFramework/HADFramework.h>
```

And in your application didFinishLaunchingWithOptions method call [HAD create]:

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HAD create];
    return YES;
}
```

Ok, let's move to your View Controller. In implementation file, import the SDK header, declare that you implement the HADBannerViewDelegate protocol and add an instance variable for the banner view:

```objective_c
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerView *bannerView;
@end
```

Then, on your View Controller's viewDidLoad implementation, use property of the HADBannerView class and add it to your view. Since HADBannerView is a subclass of UIView, you can add it to your view hierarchy just as with any other view:

```objective_c
-(void)viewDidLoad {
    self.bannerView = [[HADBannerView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 50)];
    [self.view addSubview:self.bannerView];
    [self.bannerView loadAd:@"PLACEMENT_ID" bannerSize:HADBannerSizeHeight50 delegate:self];
}
```

If you are building your app for iPad, consider using the `HADBannerSizeHeight90` size instead. The HADFramework also supports the 300x250 ad size. Configure the HADBannerView with the following ad size: `HADBannerSizeBlock300x250`:

```objective_c
-(void)viewDidLoad {
    self.bannerView = [[HADBannerView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
    [self.view addSubview:self.bannerView];
    [self.bannerView loadAd:@"PLACEMENT_ID" bannerSize:HADBannerSizeBlock300x250 delegate:self];
}
```

Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

```objective_c
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
```
