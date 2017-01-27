# Native ads

The HyperADX's Native Ads allows you to build a customized experience for the ads displayed in your app. When using the Native Ad API, instead of receiving an ad ready to be displayed, you will receive a group of ad properties such as a title, an image, a call to action. These properties are used to construct a custom UIView, which displays the ad.

**There are three actions you will need to take to implement this in your app:**

* Request an ad.
* Use the returned ad metadata to build a custom native UI.
* Register the ad's view with the `HADNativeAd` instance.

### Set up the SDK

Please complete the steps mentioned in the [Setup the SDK](../README.md#getting-started) section to set up the SDK.

### Swift implementation

Step 1. Now, in your View Controller implementation file, import the SDK and declare that you implement the `HADNativeAdDelegate` protocol as well as declare and connect instance variables to your Storyboard or .XIB:

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

Step 2. Then, add a method in your View Controller's implementation file that initializes `HADNativeAd` and request an ad to load:

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


Step 3. The next step is to show ad when content is ready. You would need to implement `hadNativeAdDidLoad` method in View Controller file.

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

#### Controlling Clickable Area

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

## Native Ads Manager

Use the Native Ads Manager when your user experience involves displaying multiple ads within a short amount of time, such as a vertical feed or horizontal scroll. An app can also use Native Ads Manager to automatically refresh and deliver ads.
Implement the Native Ads Manager along side your Native Ads integration. Native Ads Manager can be used with a publisher defined View (leveraging the Native Ads API) or with the Native Ads Template.

### Native Ads Manager with Table View Controller

#### Step 1: Create Table View Controller

1. Open your Table View Controller implementation file, add UITableViewDataSource and UITableViewDelegate. Next add `tableView`, `adsManager`, `ads`, and `tableViewContentArray` instance variables.

```swift
```

```objective-c
@interface TableViewController ()

@property (strong, nonatomic) FBNativeAdsManager *adsManager;
@property (strong, nonatomic) FBNativeAdTableViewCellProvider *ads;
@property (strong, nonatomic) NSMutableArray *tableViewContentArray;

@end
```

`adsManager` is used for requesting and storing the list of NativeAd instances.
`ads` is used for providing the UITableViewCell that shows the content of ad.
`tableViewContentArray` is used for storing the normal non-ad content.

2. Add the implementation for tableViewContentArray property to store the normal non-ad content as follows:

```swift
```

```objective-c
- (NSMutableArray *)tableViewContentArray {
    if (!_tableViewContentArray) {
    _tableViewContentArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < 10; i++) {
        NSString *displayText = [NSString stringWithFormat:@"TableView Cell #%lu", (unsigned long)(i + 1)];
        [_tableViewContentArray addObject:displayText];
    }
}

return _tableViewContentArray;
}	
```
`tableViewContentArray` is an array that contains a list of string text indexed from 1 to 10. And it will be displayed in a regular cell. 

3. In `viewDidLoad` method, add the following lines of code to setup for the table view property.
```objective-c
[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kDefaultCellIdentifier"];
}	
```

You will need to implement the required methods for `UITableViewDataSource` and `UITableViewDelegate` to show contents in the table view.
```objective-c
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewContentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
    indexPath = [self.ads adjustNonAdCellIndexPath:indexPath forStride:kRowStrideForAdCell] ?: indexPath;
    cell.textLabel.text = [self.tableViewContentArray objectAtIndex:indexPath.row];
    return cell;
}	
```

#### Step 2: Use NativeAdManager to Request Ads
You now have created a table view sample app that shows regular cells. Next, you will use `NativeAdManager` to request ads.

1. In this sample app, it will show one ad cell for every 3 regular cells. First define a static variable used for calculating which cell contains ad content as follows:
```objective-c
static NSInteger const kRowStrideForAdCell = 3; 
```

2. Add `HADNativeAdsManagerDelegate` and `HADNativeAdDelegate` delegates to the ViewController class.
```objective-c
@interface TableViewController () <HADNativeAdsManagerDelegate, HADNativeAdDelegate>
@end
```
`HADNativeAdsManagerDelegate` is used for notifying whether ads are finished loading by `HADNativeAdsManager` or an error is returned.
`HADNativeAdDelegate` is used for notifying an ad being viewed or clicked by a user.

3. In viewDidLoad method, add the following lines of code:
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDefaultCellIdentifier];

    if (!self.adsManager) {
        self.adsManager = [[HADNativeAdsManager alloc] initWithPlacementID:@"PLACEMENT_ID" numAdsRequested:5];
        // Set a delegate to get notified when the ads are loaded.
        self.adsManager.delegate = self;

        // Configure native ad manager to wait to call nativeAdsLoaded until all ad assets are loaded
        self.adsManager.mediaCachePolicy = HADNativeAdsCachePolicyAll;
}

// Load some ads
[self.adsManager loadAds];
}
```
When initializing and creating `adManager`, replace `PLACEMENT_ID` with your own placement id string. If you don't have a placement id or don't know how to get one, you can refer to the [Setup the SDK](../README.md#set-up-the-sdk)

In this example, let's request maximum 5 number of ads. This can be set in `[HADNativeAdsManager initWithPlacementID: numAdsRequested:]`

Set `mediaCachePolicy` to be `HADNativeAdsCachePolicyAll`. This will configure the native ad to wait to be called in `nativeAdDidLoad` method until all ad assets are loaded. 
You need to call `[self.adsManager loadAds];` to load ad. 

4. You need to implement `nativeAdsLoaded` and `nativeAdsFailedToLoadWithError` to check if ads are loaded successfully by the adsManager as follows:
```objective-c
- (void)nativeAdsLoaded {
    NSLog(@"Native ad was loaded, constructing native UI...");
}

- (void)nativeAdsFailedToLoadWithError:(NSError *)error {
    NSLog(@"Native ad failed to load with error: %@", error);
}
```

#### Step 3: Use NativeAdManager to Show Ads
In this step, you will learn how to use `HADNativeAdTableViewCellProvider` to display ads in the table view cell.

1. In `nativeAdsLoaded` method, add the following lines of code.
```objective-c
- (void)nativeAdsLoaded {
    NSLog(@"Native ad was loaded, constructing native UI...");
    HADNativeAdTableViewCellProvider *cellProvider =
    [[HADNativeAdTableViewCellProvider alloc] initWithManager:self.adsManager forType:HADNativeAdViewTypeHeight300];
    self.ads = cellProvider;
    self.ads.delegate = self;

    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}
```
The native ad cell provider operates over a loaded ads manager and can create table cells with native ad templates in them as well as help with the math to have a consistent distribution of ads within a table. 

2. You will modify `numberOfRowsInSection`, `cellForRowAtIndexPath` and `heightForRowAtIndexPath` methods as follows:
```objective-c
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // In this example the ads are evenly distributed within the table every kRowStrideForAdCell-th cell.
    NSUInteger count = [self.tableViewContentArray count];
    count = [self.ads adjustCount:count forStride:kRowStrideForAdCell] ?: count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads cellOf:tableView forRowAt:indexPath];
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
        // In this example we need to adjust the index back to the domain of the data.
        indexPath = [self.ads adjustNonAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell] ?: indexPath;
        cell.textLabel.text = [self.tableViewContentArray objectAtIndex:indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ads isAdCellWithIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        return [self.ads heightOf:tableView forRowAt:indexPath];
    } else {
        return 80;
    }
}
```

In `numberOfRowsInSection` method, `[HADNativeAdTableViewCellProvider adjustCount:forStride]` is called to calculate the number of cells including normal content and ads. 

In `cellForRowAtIndexPath` method, `[HADNativeAdTableViewCellProvider isAdCellAtIndexPath:forStride]` is called first to determine if the current cell contains the ad content. 

`[HADNativeAdTableViewCellProvider cellOf: forRowAt:]` fetches the cell instance that contains ad content. 

If the cell that will be shown contains regular content, you need to call `[HADNativeAdTableViewCellProvider adjustNonAdCellWithIndexPath:forStride:]` to adjust the index back to the domain of the data.

In `heightForRowAtIndexPathmethod`, you need to use `[HADNativeAdTableViewCellProvider heightOf: forRowAt:]` to fetch the height of a cell that contains the ad content. 

You can use the same way for Collections, please take a look at samples. 
