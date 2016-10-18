# Banner

The HyperAdX Banner ads allows you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app. If you're interested in other kinds of ad units, see the list of available types.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

> First of all, in your AppDelegate file create an instance of HADFramework
> Import the SDK

```swift
import HADFramework
```

> And in your application didFinishLaunchingWithOptions method call HAD.create()

Swift 2.2
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
// Override point for customization after application launch.
HAD.create()
return true
}
```

Swift 3.0
```swift
private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
// Override point for customization after application launch.
HAD.create()
return true
}
```

> Ok, let's move to your View Controller. Import the SDK, declare that you implement the HADBannerViewDelegate protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADBannerViewDelegate {
var bannerView: HADBannerView!
}
```

> Then, on your View Controller's viewDidLoad implementation, use property of the HADBannerView class and add it to your view. Since HADBannerView is a subclass of UIView, you can add it to your view hierarchy just as with any other view:

Swift 2.2
```swift
override func viewDidLoad() {
super.viewDidLoad()
bannerView = HADBannerView(frame: CGRectMake(0,0, view.frame.size.width, 50))
view.addSubview(bannerView)
bannerView.loadAd("PLACEMENT_ID", bannerSize: .Height50, delegate: self)
}
```

Swift 3.0
```swift
override func viewDidLoad() {
super.viewDidLoad()
bannerView = HADBannerView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
view.addSubview(bannerView)
bannerView.loadAd(placementId: "PLACEMENT_ID", bannerSize: .height50, delegate: self)
}
```

> If you are building your app for iPad, consider using the `HADBannerSize.Height90` size instead. The HADFramework also supports the 300x250 ad size. Configure the HADBannerView with the following ad size: `HADBannerSize.Block300x250`:

Swift 2.2
```swift
override func viewDidLoad() {
super.viewDidLoad()
bannerView = HADBannerView(frame: CGRectMake(10, 100, 300, 250))
view.addSubview(bannerView)
bannerView.loadAd("PLACEMENT_ID", bannerSize: .Block300x250, delegate: self)
}
```

Swift 3.0
```swift
override func viewDidLoad() {
super.viewDidLoad()
bannerView = HADBannerView(frame: CGRect(x: 10, y: 100, width: 300, height: 250))
view.addSubview(bannerView)
bannerView.loadAd(placementId: "PLACEMENT_ID", bannerSize: .block300x250, delegate: self)
}
```

> Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

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

> First of all, in your AppDelegate file create an instance of HADFramework
> Import the SDK header in AppDelegate.h:

```objective_c
#import <HADFramework/HADFramework.h>
```

> And in your application didFinishLaunchingWithOptions method call [HAD create]

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
[HAD create];
return YES;
}
```

> Ok, let's move to your View Controller. In implementation file, import the SDK header, declare that you implement the HADBannerViewDelegate protocol and add an instance variable for the banner view:

```objective_c
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerView *bannerView;
@end
```

> Then, on your View Controller's viewDidLoad implementation, use property of the HADBannerView class and add it to your view. Since HADBannerView is a subclass of UIView, you can add it to your view hierarchy just as with any other view:

```objective_c
-(void)viewDidLoad {
[super viewDidLoad];
self.bannerView = [[HADBannerView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 50)];
[self.view addSubview:self.bannerView];
[self.bannerView loadAd:@"PLACEMENT_ID" bannerSize:HADBannerSizeHeight50 delegate:self];
}
```

> If you are building your app for iPad, consider using the `HADBannerSizeHeight90` size instead. The HADFramework also supports the 300x250 ad size. Configure the HADBannerView with the following ad size: `HADBannerSizeBlock300x250`:

```objective_c
-(void)viewDidLoad {
[super viewDidLoad];
self.bannerView = [[HADBannerView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
[self.view addSubview:self.bannerView];
[self.bannerView loadAd:@"PLACEMENT_ID" bannerSize:HADBannerSizeBlock300x250 delegate:self];
}
```

> Then, add and implement the following three functions in your View Controller implementation file to handle ad loading failures and completions:

Before v2.1.0
```objective_c
#pragma mark - HADBannerViewDelegate

-(void)HADViewDidLoad:(HADBannerView *)view {
NSLog(@"HADViewDidLoad");
}

-(void)HADView:(HADBannerView *)view didFailWithError:(NSError *)error {
NSLog(@"HADViewDidFai:l %@", error);
}

-(void)HADViewDidClick:(HADBannerView *)view {
NSLog(@"HADViewDidClick");
}
```

After v2.1.0
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

###Admob Adapter

* [Download](https://s3-us-west-2.amazonaws.com/adpanel-public/HyperadxiOSAdmobAdapter_2.0.0.zip) and extract the AdMob adapter if needed.

* First of all you need to add new app in AdMob console.

* You will get UnitId string like 'ca-app-pub-*************/*************'.
For the next few hours you may get the AdMob errors with codes 0 or 2. Just be patient.

Then you need to add new mediation source.

* Fill `Class Name` field with a `HADCustomEventBanner`. And a `Parameter` with your HyperAdx statement string.

* Setup eCPM for new network

Now you can setting up your Xcode project.

* Put HyperAdx-SDK as described above
* Add HADCustomEventBanner.swift file

**NOTE** - In the Objective-C only project you must create swift header file as described here e.g. http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c

> Just create AdMob banner Ad as usually:

Swift 2.2
```swift
import GoogleMobileAds
import HADFramework
import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {
var bannerView: GADBannerView!

override func viewDidLoad() {
super.viewDidLoad()
let request = GADRequest()
//Banner 320x50
bannerView = GADBannerView(adSize: GADAdSize.init(size: CGSizeMake(320, 50), flags: 0))
bannerView.frame.origin.x = (UIScreen.mainScreen().bounds.width-320)/2
bannerView.frame.origin.y = 100
bannerView.adUnitID = "YOUR_ADUNIT_ID"
bannerView.rootViewController = self
bannerView.delegate = self
view.addSubview(bannerView)
bannerView.loadRequest(request)
}

//MARK: GADBannerViewDelegate
func adViewDidReceiveAd(bannerView: GADBannerView!) {
print("adViewDidReceiveAd")
}

func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
print("didFailToReceiveAdWithError: \(error)")
}
}
```

Swift 3.0
```swift
import GoogleMobileAds
import HADFramework
import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {
var bannerView: GADBannerView!

override func viewDidLoad() {
super.viewDidLoad()
let request = GADRequest()
//Banner 320x50
bannerView = GADBannerView(adSize: GADAdSize.init(size: CGSize(with: 320, height: 50), flags: 0))
bannerView.frame.origin.x = (UIScreen.main.bounds.width-320)/2
bannerView.frame.origin.y = 100
bannerView.adUnitID = "YOUR_ADUNIT_ID"
bannerView.rootViewController = self
bannerView.delegate = self
view.addSubview(bannerView)
bannerView.loadRequest(request)
}

//MARK: GADBannerViewDelegate
func adViewDidReceiveAd(bannerView: GADBannerView!) {
print("adViewDidReceiveAd")
}

func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
print("didFailToReceiveAdWithError: \(error)")
}
}
```

###Mopub Adapter

* [Download](https://s3-us-west-2.amazonaws.com/adpanel-public/HyperadxiOSMoPubAdapter_2.0.0.zip) and extract the Mopub adapter if needed.

You can use Hyperadx as a Network in Mopub's Mediation platform.

Setup SDKs:

* Integrate with Mopub SDK (https://github.com/mopub/mopub-ios-sdk/wiki/Manual-Native-Ads-Integration-for-iOS)
* Install Hyperadx SDK
* Add HADBannerCustomEvent.swift file

**NOTE** - In the Objective-C only project you must create swift header file as described here e.g. http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c

Setup Mopub Dashboard

* Create an "Hyperadx" Network in Mopub's dashboard and connect it to your Ad Units.
* In Mopub's dashboard select Orders > Add a New Order
* This screen shows forms for creating Order and Line item at the same time
* The most interested part is "Line Item Details"
* Choose Network > Custom Native Network
* Fill Class field with `HADBannerCustomEvent`
* Fill Data field with: `{"placementId": "<YOUR PLACEMENT>"}`
* In "Ad Unit Targeting" section select ad units with native format
* In Mopub's dashboard select Networks > Add New network
* Then select Custom Native Network
* Complete the fields accordingly to the Ad Unit that you want to use
* Create new Order in Orders tab
* Complete the fields accordingly to the Ad Unit that you want to use

Custom Event Class: `HADBannerCustomEvent`

Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

You can use the test placement `5b3QbMRQ`

> Add `HADBannerCustomEvent.swift` adapter in your project
Implement MoPub Banner:

Swift 2.2
```swift
import HADFramework
import UIKit

class ViewController: UIViewController, MPAdViewDelegate {
override func viewDidLoad() {
super.viewDidLoad()
//Banner 320x50
let m = MPAdView(adUnitId: "YOUR_AD_UNIT", size: CGSizeMake(320, 50))
m.delegate = self
m.frame = CGRectMake((UIScreen.mainScreen().bounds.width-320)/2, 100, 320, 50)
view.addSubview(m)
m.loadAd()
}

//MARK: MPAdViewDelegate
func viewControllerForPresentingModalView() -> UIViewController! {
return self
}

func adViewDidLoadAd(view: MPAdView!) {
print("adViewDidLoadAd")
}

func adViewDidFailToLoadAd(view: MPAdView!) {
print("adViewDidFailToLoadAd")
}

func didDismissModalViewForAd(view: MPAdView!) {
print("didDismissModalViewForAd")
}

func willPresentModalViewForAd(view: MPAdView!) {
print("willPresentModalViewForAd")
}

func willLeaveApplicationFromAd(view: MPAdView!) {
print("willLeaveApplicationFromAd")
}
}
```

Swift 3.0
```swift
import HADFramework
import UIKit

class ViewController: UIViewController, MPAdViewDelegate {
override func viewDidLoad() {
super.viewDidLoad()
//Banner 320x50
let m = MPAdView(adUnitId: "YOUR_AD_UNIT", size: CGSize(width: 320, height: 50))
m.delegate = self
m.frame = CGRect(x: (UIScreen.main.bounds.width-320)/2, y: 100, width: 320, height: 50)
view.addSubview(m)
m.loadAd()
}

//MARK: MPAdViewDelegate
func viewControllerForPresentingModalView() -> UIViewController! {
return self
}

func adViewDidLoadAd(view: MPAdView!) {
print("adViewDidLoadAd")
}

func adViewDidFailToLoadAd(view: MPAdView!) {
print("adViewDidFailToLoadAd")
}

func didDismissModalViewForAd(view: MPAdView!) {
print("didDismissModalViewForAd")
}

func willPresentModalViewForAd(view: MPAdView!) {
print("willPresentModalViewForAd")
}

func willLeaveApplicationFromAd(view: MPAdView!) {
print("willLeaveApplicationFromAd")
}
}
```

> This is your Hyperadx Banner MoPub adapter. Now you can use Mopub as usual.
