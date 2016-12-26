[![HyperADx Logo](http://d2n7xvwjxl8766.cloudfront.net/assets/site/logo-e04518160888e1f8b3795f0ce01e1909.png)](http://hyperadx.com)

## HyperADX iOS SDK

Hyper is a leading monetization and advertising platform, which enables its partners and clients to use all the power of native advertising.

## Getting Started

To get up and running with **HyperADX**, you'll need to [Create an Account](http://hyperadx.com/publishers/sign_in), [Add an Application to the Dashboard](http://hyperadx.com/publishers/traffic_sources) and create one or more Placements for your added application.


## Requirements

The following platforms and environments are supported:

* iOS 7.0+
* Xcode 7+
* Objective-C

## Set up the SDK

Please complete the steps listed below to download and set-up HADFramework - Hyper SDK for iOS.

* Download this release and extract the HADFramework for iOS.
* Open your project target _General_ tab.
* Drag the `HADFrameworkObjC.framework` file to _Embedded Binaries_. Make sure **Copy items if needed** is selected.
* Create a new _Run Script Phase_ in your app target _Build Phases_ and paste the following snippet in the script text field:
```
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/HADFrameworkObjC.framework/strip-frameworks.sh"
```
This step is required to work around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) when archiving universal binaries

## Ad implementation requirements
There are three advertiser assets that must always be included in your native ad design. Failing to include any of these three items could result in HyperADX disabling your placement. The three assets are:

* Ad Title
* CTA (Call-to-Action) Button (eg. Install Now, Learn More)
* Object of **HADMediaView must be used** for banner image loading and must be presented on the stage

## Ad implementation

In your View Controller implementation file, import the SDK header and declare that you implement the `HADNativeAdDelegate` protocol as well as declare and connect instance variables to your Storyboard or .XIB:

```objective_c
#import <HADFrameworkObjC/HADFrameworkObjC.h>
@interface MyViewController : UIViewController <HADNativeAdDelegate>
	@property (strong, nonatomic) HADNativeAd *nativeAd;
	@property (weak, nonatomic) IBOutlet UIView *bannerView;
	@property (weak, nonatomic) IBOutlet HADMediaView *bannerMediaView;
	@property (weak, nonatomic) IBOutlet HADMediaView *iconMediaView;
	@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
	@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
	@property (weak, nonatomic) IBOutlet UIButton *ctaButton;
@end
```

Then, add a method in your View Controller's implementation file that initializes `HADNativeAd` and request an ad to load:

```objective_c
- (void)viewDidLoad {
	self.nativeAd = [[HADNativeAd alloc] initWithPlacementId:@"PLACEMENT_ID" content:@[HADAdContentTitle, HADAdContentDescription, HADAdContentBanner, HADAdContentIcon] delegate:self];
    	[self.nativeAd loadAd];
}
```

You may set `content` param on HADNativeAd initialization to get only needed properties. If you didn't set `content` param then you get all properties.


to get the title text:

```objective_c
HADAdContentTitle
```

to get the description text:

```objective_c
HADAdContentDescription
```

to get the banner:

```objective_c
HADAdContentBanner
```

to get the icon:

```objective_c
HADAdContentIcon
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to construct the ad once it has loaded:

```objective_c
-(void)HADNativeAdDidFail:(HADNativeAd *)nativeAd error:(NSError *)error {
	NSLog(@"ERROR: %@",error.localizedDescription);
}

-(void)HADNativeAdDidLoad:(HADNativeAd *)nativeAd {
	[self.bannerMediaView loadHADBanner:nativeAd animated:NO completion:^(NSError * _Nullable error, UIImage * _Nullable image) {
		if (!error) {
    			NSLog(@"Banner downloaded");
		} else {
    			NSLog(@"Banner download error: %@", error);
		}
	}];
	[self.iconMediaView loadHADIcon:nativeAd animated:NO completion:^(NSError * _Nullable error, UIImage * _Nullable image) {
		if (!error) {
    			NSLog(@"Icon downloaded");
		} else {
    			NSLog(@"Icon download error: %@", error);
		}
	}];
	[self.titleLabel setText:nativeAd.title];
	[self.descriptionLabel setText:nativeAd.desc];
	[self.ctaButton setTitle:nativeAd.cta forState:UIControlStateNormal];
}

-(void)HADNativeAdDidClick:(HADNativeAd *)nativeAd {
	NSLog(@"CLICKED AD");
}
```

Handle click on your implementation of "call to action" button:

```objective_c
- (IBAction)handleClick:(id)sender {
	[self.nativeAd handleClick];
}
```
