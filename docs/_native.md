# Native ads

The HyperADX's Native Ads allows you to build a customized experience for the ads you show in your app. When using the Native Ad API, instead of receiving an ad ready to be displayed, you will receive a group of ad properties such as a title, an image, a call to action, and you will have to use them to construct a custom UIView where the ad is shown.

**There are three actions you will need to take to implement this in your app:**

* Request an ad
* Use the returned ad metadata to build a custom native UI
* Register the ad's view with the `HADNativeAd` instance

### Set up the SDK

[Please complete these steps](../README.md#set-up-the-sdk)

## Requirements
There are three advertiser assets that must always be included in your native ad design. Failing to include any of these three items could result in HyperADX disabling your placement. The three assets are:

* Ad Title
* CTA (Call-to-Action) Button (eg. Install Now, Learn More)
* Object of HADMediaView must be used and presented

### Swift implementation

> Now, in your View Controller implementation file, import the SDK and declare that you implement the `HADNativeAdDelegate` protocol as well as declare and connect instance variables to your Storyboard or .XIB:

```swift
import HADFramework
class MyViewController: UIViewController, HADNativeAdDelegate {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var imageView: HADMediaView!
    @IBOutlet weak var iconView: HADMediaView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cta: UIButton?

    var nativeAd: HADNativeAd! = nil

}
```

Then, add a method in your View Controller's implementation file that initializes `HADNativeAd` and request an ad to load:

```swift
override func viewDidLoad() {
	super.viewDidLoad()
	nativeAd = HADNativeAd(placementId: "PLACEMENT_ID", delegate: self)
	nativeAd.loadAd()
}
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to construct the ad once it has loaded:

```swift
//MARK: HADNativeAd Delegate
func HADAd(nativeAd: HADNativeAd, didFailWithError error: NSError) {
	print("ERROR: \(error.localizedDescription)")
}

func HADNativeAdDidLoad(nativeAd: HADNativeAd) {
	imageView.loadHADBanner(nativeAd, animated: true) { (error, image) in
    		if error != nil {
        		print("ERROR: CAN'T DOWNLOAD BANNER \(error)")
        		return
    		}
    		print("BANNER DOWNLOADED")
	}
	iconView.loadHADIcon(nativeAd, animated: true) { (error, image) in
    		if error != nil {
        		print("ERROR: CAN'T DOWNLOAD ICON \(error)")
        		return
    		}
    		print("ICON DOWNLOADED")
	}
	titleLabel.text = nativeAd.title
	descLabel.text = nativeAd.desc
	cta?.setTitle(nativeAd.cta, forState: .Normal)
}

func HADNativeAdDidClick(nativeAd: HADNativeAd) {
	print("CLICKED AD")
}
```

Handle click on your implementation of "call to action" button

```swift
@IBAction func adClicked() {
	nativeAd.handleClick()
}
```

### Objective-C implementation

Now, in your View Controller implementation file, import the SDK header and declare that you implement the `HADNativeAdDelegate` protocol as well as declare and connect instance variables to your Storyboard or .XIB:

```objective_c
#import <HADFramework/HADFramework.h>
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
	[super viewDidLoad];
	self.nativeAd = [[HADNativeAd alloc] initWithPlacementId:@"PLACEMENT_ID" content:@[HADAdContentTitle, HADAdContentDescription, HADAdContentBanner, HADAdContentIcon] delegate:self];
    	[self.nativeAd loadAd];
}
```

You may set `content` param on HADNativeAd initialization to get only needed properties. If you didn't set `content` param then you get all properties.

to get title text

```objective_c
HADAdContentTitle
```

to get description text

```objective_c
HADAdContentDescription
```

to get banner

```objective_c
HADAdContentBanner
```

to get icon

```objective_c
HADAdContentIcon
```

Now that you have added the code to load the ad, add the following functions to handle loading failures and to construct the ad once it has loaded:

```objective_c
-(void)HADNativeAdDidFail:(HADNativeAd *)nativeAd error:(NSError *)error
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

-(void)HADNativeAdDidClick:(HADNativeAd *)nativeAd
	NSLog(@"CLICKED AD");
}
```

Handle click on your implementation of "call to action" button

```objective_c
- (IBAction)handleClick:(id)sender {
	[self.nativeAd handleClick];
}
```

## Native Ad iOS templates

The Native Ad templates allows you to use prepared Ad banner views but with possibility of full customization.

Just add HADBannerTemplateView to your view controller and set desired banner template and custom params.

### You can choose from six layouts:

Layout | Description
--------- | -----------
`HADBannerTemplateTypes.blockOne` | Flexible block banner with aspect ratio 320:230
`HADBannerTemplateTypes.blockTwo` | Flexible block banner with aspect ratio 320:300
`HADBannerTemplateTypes.blockThree` | Flexible block banner with aspect ratio 320:340
`HADBannerTemplateTypes.lineOne` | Line banner with 50pt height
`HADBannerTemplateTypes.lineTwo` | Line banner with 60pt height
`HADBannerTemplateTypes.lineThree` | Line banner with 90pt height

### Custom params

All custom params starts with `custom` prefix

Group | Param | Description
--------- | ----------- | -----------
Background color | `customBackgroundColor` | Whole ad background
Background color | `customButtonBackgroundColor` | CTA button background
Background color | `customAgeRatingBackgroundColor` | AgeRating label background
Text colors | `customTitleTextColor` | Title label text color
Text colors | `customDescriptionTextColor` | Description label text color
Text colors | `customPoweredByTextColor` | PoweredBy label text color
Text colors | `customAgeRatingTextColor` | AgeRating label text color
Text colors | `customButtonTitleColor` | CTA button title text color
Corner radius | `customIconCornerRadius` | Icon
Corner radius | `customBannerCornerRadius` | Banner
Corner radius | `customButtonCornerRadius` | CTA button
Corner radius | `customAgeRatingCornerRadius` | Age rating label
CTA button border | `customButtonBorderColor` | Border color
CTA button border | `customButtonBorderWidth` | Border width
Star rating | `customStarRatingFilledColor` | Filled color
Star rating | `customStarRatingEmptyColor` | Empty color
Star rating | `customStarRatingTextColor` | Right text color
Click mode | `customClickMode = .button` | Handle click only on button
Click mode | `customClickMode = .wholeBanner` | Handle click everywhere

### Swift example

```swift
import HADFramework

class MyViewController: UIViewController, HADBannerTemplateViewDelegate {
    @IBOutlet weak var bannerTemplateView: HADBannerTemplateView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Just set HADBannerTemplateTypes param in loadAd method
        bannerTemplateView.loadAd("PLACEMENT_ID", bannerTemplate: .BlockOne, delegate: self)
        //And customize everything
        bannerTemplateView.customBackgroundColor = UIColor.lightGrayColor()
        bannerTemplateView.customTitleTextColor = UIColor.blueColor()
        bannerTemplateView.customDescriptionTextColor = UIColor.darkGrayColor()
        bannerTemplateView.customIconCornerRadius = 6
        bannerTemplateView.customButtonBackgroundColor = UIColor.clearColor()
        bannerTemplateView.customButtonBorderColor = UIColor.purpleColor()
        bannerTemplateView.customButtonBorderWidth = 1
        bannerTemplateView.customButtonTitleColor = UIColor.purpleColor()
        bannerTemplateView.customButtonCornerRadius = 6
        bannerTemplateView.customBannerCornerRadius = 6
        bannerTemplateView.customStarRatingFilledColor = UIColor.greenColor()
        bannerTemplateView.customStarRatingEmptyColor = UIColor.purpleColor()
        bannerTemplateView.customStarRatingTextColor = UIColor.purpleColor()
        bannerTemplateView.customClickMode = .Button
    }

    //MARK: HADBannerTemplateViewDelegate

    func HADTemplateViewDidLoad(view: HADBannerTemplateView) {
        print("AD LOADED")
    }

    func HADTemplateViewDidClick(view: HADBannerTemplateView) {
        print("CLICKED AD")
    }

    func HADTemplateView(view: HADBannerTemplateView, didFailWithError error: NSError?) {
        print("ERROR: %@", error?.localizedDescription)
    }
}
```

### Objective-C example

```objective_c
#import <HADFramework/HADFramework.h>

@interface MyViewController () <HADBannerTemplateViewDelegate>
@property (weak, nonatomic) IBOutlet HADBannerTemplateView *bannerTemplateView;
@end

@interface MyViewController : UIViewController <HADNativeAdDelegate>
-(void)viewDidLoad {
	[super viewDidLoad];
	//Just set HADBannerTemplateTypes param in loadAd method
	[self.bannerTemplateView loadAd:@"PLACEMENT_ID" bannerTemplate:HADBannerTemplateTypesBlockOne delegate:self];
	//And customize everything
	[self.bannerTemplateView setCustomBackgroundColor:[UIColor lightGrayColor]];
	[self.bannerTemplateView setCustomTitleTextColor:[UIColor blackColor]];
	[self.bannerTemplateView setCustomDescriptionTextColor:[UIColor darkGrayColor]];
	[self.bannerTemplateView setCustomIconCornerRadius:6.0];
	[self.bannerTemplateView setCustomButtonBackgroundColor:[UIColor clearColor]];
	[self.bannerTemplateView setCustomButtonBorderColor:[UIColor purpleColor]];
	[self.bannerTemplateView setCustomButtonBorderWidth:1.0];
	[self.bannerTemplateView setCustomButtonTitleColor:[UIColor purpleColor]];
	[self.bannerTemplateView setCustomButtonCornerRadius:6.0];
	[self.bannerTemplateView setCustomBannerCornerRadius :6.0];
	[self.bannerTemplateView setCustomAgeRatingCornerRadius:4.0];
	[self.bannerTemplateView setCustomStarRatingFilledColor:[UIColor greenColor]];
	[self.bannerTemplateView setCustomStarRatingEmptyColor:[UIColor purpleColor]];
	[self.bannerTemplateView setCustomStarRatingTextColor:[UIColor purpleColor]];
	[self.bannerTemplateView setCustomClickMode:BannerTemplateCustomClickModesButton];
}
```

```
#pragma mark - HADBannerTemplateViewDelegate

-(void)HADTemplateViewDidLoad:(HADBannerView *)view {
	NSLog(@"HADTemplateViewDidLoad");
}

-(void)HADTemplateView:(HADBannerView *)view didFailWithError:(NSError *)error {
	NSLog(@"HADTemplateViewDidFai:l %@", error);
}

-(void)HADTemplateViewDidClick:(HADBannerView *)view {
	NSLog(@"HADTemplateViewDidClick");
}

@end
```

As you can see it's really easy to use!
