# Interstitial ads


The HyperADX Interstitial ads allow you to monetize your iOS apps with banner ads. This guide explains how to add banner ads to your app. If you're interested in other kinds of ad units, see the list of available types.

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

### Swift implementation

First of all, in your AppDelegate file, create an instance of HADFramework

Import the SDK

```swift
import HADFramework
```

And in your application didFinishLaunchingWithOptions method call HAD.create()

```swift
private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    HAD.create()
    return true
}
```

Ok, let's move to your View Controller. Import the SDK, declare that you implement the HADInterstitialDelegate protocol and add an instance variable for the interstitial ad unit:

```swift
import HADFramework

class MyViewController: UIViewController, HADInterstitialDelegate {
}
```

Add a function in your View Controller that initializes the interstitial view. You will typically call this function ahead of the time you want to show the ad:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    loadHADInterstitalAd()
}

func loadHADInterstitalAd() {
    let interstitial = HADInterstitial(placementId: "PLACEMENT_ID")
    interstitial.delegate = self
    interstitial.loadAd()
}
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to display the ad once it has loaded:

```swift
//MARK: HADInterstitial Delegate

func HADInterstitialDidLoad(controller: HADInterstitial) {
    controller.modalTransitionStyle = .coverVertical
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true, completion: nil)
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

> And in your application didFinishLaunchingWithOptions method call [HAD create]

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HAD create];
    return YES;
}
```

Ok, let's move to your View Controller. In implementation file, import the SDK header, declare that you implement the HADInterstitialDelegate protocol and add an instance variable for the interstitial ad unit:

```objective_c
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADInterstitialDelegate>
@property (strong, nonatomic) HADInterstitial *hadInterstitial;
@end
```

Add a function in your View Controller that initializes the interstitial view. You will typically call this function ahead of the time you want to show the ad:

```objective_c
- (void) viewDidLoad {
    [self loadHADInterstitialAd];
}

- (void) loadHADInterstitialAd {
    self.hadInterstitial = [[HADInterstitial alloc] initWithPlacementId:@"PLACEMENT_ID"];
    self.hadInterstitial.delegate = self;
    [self.hadInterstitial loadAd];
}
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to display the ad once it has loaded:

```objective_c
#pragma mark - HADInterstitialDelegate

-(void)HADInterstitialDidLoadWithController:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidLoad");
    self.hadInterstitial.modalPresentationStyle = UIModalPresentationFullScreen;
    self.hadInterstitial.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.hadInterstitial animated:YES completion:nil];
}

-(void)HADInterstitialDidFailWithController:(HADInterstitial *)controller error:(NSError *)error {
    NSLog(@"HADInterstitialDidFail: %@", error);
}
```

Optionally, you can add the following functions to handle the cases where the full screen ad is closed or when the user clicks on it:

```objective_c
-(void)HADInterstitialDidClickWithController:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidClick");
}

-(void)HADInterstitialWillCloseWithController:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialWillClose");
}

-(void)HADInterstitialDidCloseWithController:(HADInterstitial *)controller {
    NSLog(@"HADInterstitialDidClose");
}
```
