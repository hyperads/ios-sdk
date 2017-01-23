# Native ads

The HyperADX's Native Ads allows you to build a customized experience for the ads displayed in your app. When using the Native Ad API, instead of receiving an ad ready to be displayed, you will receive a group of ad properties such as a title, an image, a call to action. These properties are used to construct a custom UIView, which displays the ad.

**There are three actions you will need to take to implement this in your app:**

* Request an ad.
* Use the returned ad metadata to build a custom native UI.
* Register the ad's view with the `HADNativeAd` instance.

### Set up the SDK

Please complete the steps mentioned in the [Setup the SDK](../README.md#getting-started) section to set up the SDK.

### Swift implementation

1. Now, in your View Controller implementation file, import the SDK and declare that you implement the `HADNativeAdDelegate` protocol as well as declare and connect instance variables to your Storyboard or .XIB:

```swift
import HADFramework
class MyViewController: UIViewController, HADNativeAdDelegate {
@IBOutlet weak var adView: UIView!
@IBOutlet weak var mediaView: HADMediaView!
@IBOutlet weak var iconImageView: UIImageView!
@IBOutlet weak var titleLabel: UILabel!
@IBOutlet weak var descLabel: UILabel!
@IBOutlet weak var ctaButton: UIButton?

var nativeAd: HADNativeAd! = nil
}
```

2. Then, add a method in your View Controller's implementation file that initializes `HADNativeAd` and request an ad to load:

```swift
override func viewDidLoad() {
super.viewDidLoad()

nativeAd = HADNativeAd(placementId: "PLACEMENT_ID")
nativeAd.delegate = self;
nativeAd.mediaCachePolicy = .all;
nativeAd.loadAd()
}
```

Replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

Set `mediaCachePolicy` to be `.all`. This will configure native ad to wait to call `hadNativeAdDidLoad` until all ad assets are loaded. 

HyperADX supports five cache options in native ads as defined in the enum `HADNativeAdsCachePolicy`:

Cache Constants | Description
--------- | -----------
`NONE` | No pre-caching, default
`ICON` | Pre-cache ad icon
`IMAGE` | Pre-cache ad images
`VIDEO` | Pre-cache ad video
`ALL` | Pre-cache all (icon, images, and video)


3. The next step is to show ad when content is ready. You would need to implement `hadNativeAdDidLoad` method in View Controller file.

```swift
//MARK: HADNativeAd Delegate
func hadNativeAdDidLoad(nativeAd: HADNativeAd) {
if self.nativeAd != nil {
self.nativeAd.unregisterView()
}

self.nativeAd = nativeAd

// Wire up UIView with the native ad; the whole UIView will be clickable.
self.nativeAd.registerViewForInteraction(adView:adView, withViewController:self)

// Create native UI using the ad metadata.
self.mediaView.setNativeAd(nativeAd: nativeAd)

nativeAd.icon?.loadImageAsyncWithBlock(){ (error, image) in
if error != nil {
print("ERROR: CAN'T DOWNLOAD ICON \(error)")
return
}

self.iconImageView.image = image
print("ICON DOWNLOADED")
}

self.titleLabel.text = nativeAd.title
self.descLabel.text = nativeAd.body
self.ctaButton.setTitle(nativeAd.callToAction, for: .normal)
self.ctaButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
}

func hadNativeAdDidClick(nativeAd: HADNativeAd) {
print("hadNativeAdDidClick")
}

func hadNativeAdDidFail(nativeAd: HADNativeAd, withError error: NSError?) {
print("hadNativeAdDidFail: \(error?.localizedDescription)")
}

```

First, you will need to check if there is an existing nativeAd object. If there is, you will need to call `unregisterView` method. Then you will call  `registerViewForInteraction:withViewController:` method. 

What `registerViewForInteraction` mainly does is register what views will be tappable and what the delegate is to notify when a registered view is tapped. In this case, all views inside `adView` will be tappable and when the view is tapped, ViewController will be notified through `HADNativeAdDelegate`. 

`mediaView` contains the media content, either picture or video, of the ad. You will need to call `setNativeAd` method to set the content of `nativeAd` to the view. 

You will call `loadImageAsyncWithBlock` to asynchronously load the image content of the ad icon.

##### Controlling Clickable Area
#
For finer control of what is clickable, you can use the ` registerViewForInteraction:withViewController:withClickableViews:` method to register a list of views that can be clicked. For example if we only want to make the ad image and the call to action button clickable in the previous example, we can write like this:

```swift
//MARK: HADNativeAd Delegate
func hadNativeAdDidLoad(nativeAd: HADNativeAd) {
...
// Wire up UIView with the native ad; the whole UIView will be clickable.
self.nativeAd.registerViewForInteraction(adView: self.adView, withViewController: self, withClickableViews: [mediaView, ctaButton])
...
}
```

## Native Ads Template

The Native Ad templates allows you to use prepared Ad banner views but with possibility of full customization.

```swift
func hadNativeAdDidLoad(nativeAd: HADNativeAd) {
let adView:HADNativeAdView = HADNativeAdView(nativeAd:nativeAd, withType:.height300);

view.addSubview(adView)

let height = HADNativeAdViewType.getSize(.height300).height
adView.frame = CGRect(x:0, y:100, width:self.view.frame.width, height:height);

nativeAd.registerViewForInteraction(adView:adView, withViewController:self)
}
```

Custom Ad Formats come in four templates:

Template View Type | Height | Width	| Attributes Included
--------- | ----------- | ----------- | -----------
`HADNativeAdViewType.height100` | 100dp | Flexible width | Icon, title, context, and CTA button
`HADNativeAdViewType.height120` | 120dp | Flexible width | Icon, title, context, description, and CTA button
`HADNativeAdViewType.height300` | 300dp | Flexible width | Image, icon, title, context, description, and CTA button
`HADNativeAdViewType.height400` | 400dp | Flexible width | Image, icon, title, subtitle, context, description and CTA button

#### Customization

With a native custom template, you can customize the following elements:

- Height
- Width
- Background Color
- Title Color
- Title Font
- Description Color
- Description Font
- Button Color
- Button Title Color
- Button Title Font
- Button Border Color

If you want to customize certain elements, then it is recommended to use a design that fits in with your app's layouts and themes.

You will need to build `HADNativeAdViewAttributes` object and provide a loaded native ad to render these elements:


```swift
func hadNativeAdDidLoad(nativeAd: HADNativeAd) {

let attributes:HADNativeAdViewAttributes = HADNativeAdViewAttributes();
attributes.backgroundColor = UIColor.black
attributes.buttonColor = UIColor.red
attributes.buttonTitleColor = UIColor.white

let adView:HADNativeAdView = HADNativeAdView(nativeAd:nativeAd, withType:.height300, withAttributes:attributes);
...
}
```


