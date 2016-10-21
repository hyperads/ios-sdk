# Interstitial ads


The HyperADX Interstitial ads allows you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app. If you're interested in other kinds of ad units, see the list of available types.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

> First of all, in your AppDelegate file create an instance of HADFramework
> Import the SDK

```swift
import HADFramework
```

And in your application didFinishLaunchingWithOptions method call HAD.create()

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  // Override point for customization after application launch.
  HAD.create()
  return true
}
```

Ok, let's move to your View Controller. Import the SDK, declare that you implement the HADInterstitialDelegate protocol and add an instance variable for the interstitial ad unit:

```swift
import UIKit
import HADFramework

class MyViewController: UIViewController, HADInterstitialDelegate {

}
```

Add a function in your View Controller that initializes the interstitial view. You will typically call this function ahead of the time you want to show the ad:

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  loadInterstitalAd()
}

func loadInterstitalAd() {
  let interstitial = HADInterstitial(placementId: "PLACEMENT_ID")
  interstitial.delegate = self
  interstitial.loadAd()
}
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to display the ad once it has loaded:

Swift 2.2
```swift
//MARK: HADInterstitial Delegate

func HADInterstitialDidLoad(controller: HADInterstitial) {
  controller.modalTransitionStyle = .CoverVertical
  controller.modalPresentationStyle = .FullScreen
  presentViewController(controller, animated: true, completion: nil)
}

func HADInterstitialDidFail(controller: HADInterstitial, error: NSError?) {
  print("HADInterstitialDidFail: \(error)")
}
```

Optionally, you can add the following functions to handle the cases where the full screen ad is closed or when the user clicks on it:

```swift
func HADInterstitialDidClick(controller: HADInterstitial) {
  print("HADInterstitialDidClick")
}

func HADInterstitialWillClose(controller: HADInterstitial) {
  print("HADInterstitialWillClose")
}

func HADInterstitialDidClose(controller: HADInterstitial) {
  print("HADInterstitialDidClose")
}
```

### Objective-C implementation

First of all, in your AppDelegate file create an instance of HADFramework

Import the SDK header in AppDelegate.h:

```objective_c
#import <HADFramework/HADFramework.h>
```

And in your application didFinishLaunchingWithOptions method call [HAD create]

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [HAD create];
  return YES;
}
```

Ok, let's move to your View Controller. In implementation file, import the SDK header, declare that you implement the HADInterstitialDelegate protocol and add an instance variable for the interstitial ad unit:

```objective_c
#import <UIKit/UIKit.h>
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADInterstitialDelegate>
@property (strong, nonatomic) HADInterstitial *interstitial;
@end
```

Add a function in your View Controller that initializes the interstitial view. You will typically call this function ahead of the time you want to show the ad:

```objective_c
- (void) viewDidLoad {
  [super viewDidLoad];

  [self loadInterstitialAd];
}

- (void) loadInterstitalAd {
  self.interstitial = [[HADInterstitial alloc] initWithPlacementId:@"PLACEMENT_ID"];
  self.interstitial.delegate = self;
  [self.interstitial loadAd];
}
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to display the ad once it has loaded:

```objective_c
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
```

Optionally, you can add the following functions to handle the cases where the full screen ad is closed or when the user clicks on it:

```objective_c
-(void)HADInterstitialDidClick:(HADInterstitial *)controller {
  NSLog(@"HADInterstitialDidClick");
}

-(void)HADInterstitialWillClose:(HADInterstitial *)controller {
  NSLog(@"HADInterstitialWillClose");
}

-(void)HADInterstitialDidClose:(HADInterstitial *)controller {
  NSLog(@"HADInterstitialDidClose");
}
```
