# Mopub Adapter

## iOS

* [Download](https://github.com/hyperads/ios-sdk/releases) and extract the HADFramework for iOS.

* You can find Mopub adapter example in HyperadxiOSADs_Sample_VERSION/Mediation Adapters/MoPub/.

Setup SDKs:

* [Integrate](https://github.com/mopub/mopub-ios-sdk/wiki/Manual-Native-Ads-Integration-for-iOS) with Mopub SDK
* Install Hyperadx SDK

**NOTE** - In the Objective-C only project you must create swift header file as described [here](http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c)

### Setup Mopub Dashboard

* Create an "Hyperadx" Network in Mopub's dashboard and connect it to your Ad Units. In Mopub's dashboard select Networks > Add New network

![Mopub-1]
(/images/adapters/ios/mopub1.png)

* Then select Custom Native Network

![Mopub-2]
(/images/adapters/ios/mopub2.png)

* Complete the fields accordingly to the Ad Unit that you want to use

![Mopub-3]
(/images/adapters/ios/mopub3.png)

### Native ads

* Add HADNativeAdAdapter.swift and HADNativeCustomEvent.swift files
* Custom Event Class: `HADNativeCustomEvent`
* Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

> Add `HADNativeCustomEvent.swift` and `HADNativeAdAdapter.swift` adapter files in your project
> Implement MoPub NativeViewController:

```swift
import HADFramework
import UIKit

class NativeViewController: UIViewController, MPNativeAdRendering, MPNativeAdDelegate {
    @IBOutlet weak var nativeView: NativeView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var callToActionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = MPStaticNativeAdRendererSettings()
        settings.renderingViewClass = NativeView.self
        let config = MPStaticNativeAdRenderer.rendererConfigurationWithRendererSettings(settings)
        config.supportedCustomEvents = ["HADNativeCustomEvent"]
        let request = MPNativeAdRequest(adUnitIdentifier: "YOUR_AD_UNIT", rendererConfigurations: [config])
        request.startWithCompletionHandler { (request, nativeAd, error) in
            if error != nil {
                print("Loading error")
            } else {
                print("Ad loaded")
                nativeAd.delegate = self
                do {
                    let v = try nativeAd.retrieveAdView()
                    v.frame = self.view.bounds
                    self.view.addSubview(v)
                } catch let error {
                    print("ERROR: \(error)")
                }
            }
        }
    }

    //MARK: MPNativeAdRendering
    func nativeTitleTextLabel() -> UILabel! {
        return titleLabel
    }

    func nativeMainTextLabel() -> UILabel! {
        return mainTextLabel
    }

    func nativeCallToActionTextLabel() -> UILabel! {
        return callToActionLabel!
    }

    func nativeIconImageView() -> UIImageView! {
        return iconImageView
    }

    func nativeMainImageView() -> UIImageView! {
        return mainImageView
    }

    func nativeVideoView() -> UIView! {
        return UIView()
    }

    //MARK: MPNativeAdDelegate
    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
}
```

> And implement MoPubNativeAdRenderer, e.g.:

```swift
class NativeView: UIView, MPNativeAdRenderer {
    //MARK: MPNativeAdRenderer
    var settings: MPNativeAdRendererSettings!

    required init!(rendererSettings: MPNativeAdRendererSettings!) {
        super.init(frame: CGRectZero)
        settings = rendererSettings
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    static func rendererConfigurationWithRendererSettings(rendererSettings: MPNativeAdRendererSettings!) -> MPNativeAdRendererConfiguration! {
        let settings = MPStaticNativeAdRendererSettings()
        settings.renderingViewClass = NativeView.self
        let config = MPNativeAdRendererConfiguration()
        config.rendererSettings = settings
        config.supportedCustomEvents = ["NativeView"]
        return config
    }

    func retrieveViewWithAdapter(adapter: MPNativeAdAdapter!) throws -> UIView {
        return UIView()
    }
}
```

### Interstitial

* Custom Event Class: `HADInterstitialCustomEvent`
* Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

> Add `HADInterstitialCustomEvent.swift` adapter in your project. Implement MoPub Interstitial:

```swift
import HADFramework
import UIKit

class ViewController: UIViewController, MPInterstitialAdControllerDelegate {
    var interstitial: MPInterstitialAdController!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Interstitial
        interstitial = MPInterstitialAdController(forAdUnitId: "YOUR_AD_UNIT")
        interstitial.delegate = self
        interstitial.loadAd()
    }

    //MARK: MPInterstitialAdControllerDelegate
    func interstitialDidLoadAd(interstitial: MPInterstitialAdController!) {
        print("interstitialDidLoadAd")
        interstitial.showFromViewController(self)
    }

    func interstitialDidFailToLoadAd(inter: MPInterstitialAdController!) {
        print("interstitialDidFailToLoadAd")
        interstitial = MPInterstitialAdController(forAdUnitId: "5b0f8ff979a840b4928ca7fd14ec82e7")
        interstitial.delegate = self
        interstitial.loadAd()
    }
}
```

### Banner

Custom Event Class: `HADBannerCustomEvent`

Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

> Add `HADBannerCustomEvent.swift` adapter in your project
Implement MoPub Banner:

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

## Android

* [Download](https://github.com/hyperads/android-MoPub-adapter/releases) and extract the Mopub adapter if needed.

You can use Hyperadx as a Network in Mopub's Mediation platform.
Setup SDKs

* [Integrate](https://github.com/mopub/mopub-android-sdk/wiki/Getting-Started) with Mopub SDK
* Install Hyperadx SDK

Setup Mopub Dashboard

* Create an "Hyperadx" Network in Mopub's dashboard and connect it to your Ad Units.
* In Mopub's dashboard select Networks > Add New network

Then select Custom Native Network. Complete the fields accordingly to the Ad Unit that you want to use

### Native

* Custom Event Class: `com.mopub.nativeads.HyperadxNativeMopub`
* Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement "5b3QbMRQ"**

> Add adapter in your project. Create package "com.mopub.nativeads" in your project and put this class in there:

```java
HyperadxNativeMopub.java:

package com.mopub.nativeads;
import android.app.Activity;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.View;
import com.hyperadx.lib.sdk.nativeads.Ad;
import com.hyperadx.lib.sdk.nativeads.AdListener;
import com.hyperadx.lib.sdk.nativeads.HADNativeAd;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class HyperadxNativeMopub extends CustomEventNative {
    private static final String PLACEMENT_KEY = "PLACEMENT";
    com.hyperadx.lib.sdk.nativeads.HADNativeAd nativeAd;

    @Override
    protected void loadNativeAd(final @NonNull Activity activity, final @NonNull CustomEventNativeListener customEventNativeListener, @NonNull Map<String, Object> localExtras, @NonNull Map<String, String> serverExtras) {
        final String placement;
        if ((serverExtras != null) && serverExtras.containsKey(PLACEMENT_KEY)) {
            placement = serverExtras.get(PLACEMENT_KEY);
 } else {
            customEventNativeListener.onNativeAdFailed(NativeErrorCode.NATIVE_ADAPTER_CONFIGURATION_ERROR);
            return;
        }

        nativeAd = new com.hyperadx.lib.sdk.nativeads.HADNativeAd(activity, placement); //Native AD constructor
        nativeAd.setContent("title,icon,description");
        nativeAd.setAdListener(new AdListener() { // Add Listeners
            @Override
            public void onAdLoaded(Ad ad) {
                customEventNativeListener.onNativeAdLoaded(new HyperadxNativeAd(ad, nativeAd, activity));

            @Override
            public void onError(Ad nativeAd, String error) { // Called when load is fail
                customEventNativeListener.onNativeAdFailed(NativeErrorCode.EMPTY_AD_RESPONSE);
            }

            @Override
            public void onAdClicked() { // Called when user click on AD
                Log.wtf("TAG", "AD Clicked");
            }
        });
        nativeAd.loadAd();


    class HyperadxNativeAd extends StaticNativeAd {
        final Ad hadModel;
        final com.hyperadx.lib.sdk.nativeads.HADNativeAd nativeAd;
        final ImpressionTracker impressionTracker;
        final NativeClickHandler nativeClickHandler;
        final Activity activity;
        public HyperadxNativeAd(@NonNull Ad customModel, HADNativeAd nativeAd, Activity activity) {

            hadModel = customModel;
            this.nativeAd = nativeAd;
            this.activity = activity;
            impressionTracker = new ImpressionTracker(activity);
            nativeClickHandler = new NativeClickHandler(activity);
            setIconImageUrl(hadModel.getIcon_url());
            setMainImageUrl(hadModel.getImage_url());
            setTitle(hadModel.getTitle());
            setText(hadModel.getDescription());
            setClickDestinationUrl(hadModel.getClickUrl());
            for (Ad.Tracker tracker : hadModel.getTrackers())
                if (tracker.getType().equals("impression")) {
                    addImpressionTracker(tracker.getUrl());
                }

        @Override
        public void prepare(final View view) {
            impressionTracker.addView(view, this);
            nativeClickHandler.setOnClickListener(view, this);
        }

        @Override
        public void recordImpression(final View view) {
            notifyAdImpressed();
            for (Ad.Tracker tracker : hadModel.getTrackers())
                if (tracker.getType().equals("impression")) {
                    new LoadUrlTask().execute(tracker.getUrl());
                }

        @Override
        public void handleClick(final View view) {
            notifyAdClicked();
            nativeClickHandler.openClickDestinationUrl(getClickDestinationUrl(), view);
            if (hadModel.getClickUrl() != null)
                new LoadUrlTask().execute(hadModel.getClickUrl());
        }

        private class LoadUrlTask extends AsyncTask<String, Void, String> {
            String userAgent;
            public LoadUrlTask() {
                userAgent = com.hyperadx.lib.sdk.Util.getDefaultUserAgentString(activity);

            @Override
            protected String doInBackground(String... urls) {
                String loadingUrl = urls[0];
                URL url = null;
                try {
                    url = new URL(loadingUrl);
                } catch (MalformedURLException e) {
                    return (loadingUrl != null) ? loadingUrl : "";
                }
                com.hyperadx.lib.sdk.HADLog.d("Checking URL redirect:" + loadingUrl);
                int statusCode = -1;
                HttpURLConnection connection = null;
                String nextLocation = url.toString();
                Set<String> redirectLocations = new HashSet<String>();
                redirectLocations.add(nextLocation);
                try {
                    do {
                        connection = (HttpURLConnection) url.openConnection();
                        connection.setRequestProperty("User-Agent",
                                userAgent);
                        connection.setInstanceFollowRedirects(false);
                        statusCode = connection.getResponseCode();
                        if (statusCode == HttpURLConnection.HTTP_OK) {
                            connection.disconnect();
                            break;
                        } else {
                            nextLocation = connection.getHeaderField("location");
                            connection.disconnect();
                            if (!redirectLocations.add(nextLocation)) {
                                com.hyperadx.lib.sdk.HADLog.d("URL redirect cycle detected");
                                return "";
                            }
                            url = new URL(nextLocation);
                        }
                    }

                    while (statusCode == HttpURLConnection.HTTP_MOVED_TEMP || statusCode == HttpURLConnection.HTTP_MOVED_PERM
                            || statusCode == HttpURLConnection.HTTP_UNAVAILABLE
                            || statusCode == HttpURLConnection.HTTP_SEE_OTHER);
                } catch (IOException e) {
                    return (nextLocation != null) ? nextLocation : "";
                } finally {
                    if (connection != null)
                        connection.disconnect();
                }
                return nextLocation;

            @Override
            protected void onPostExecute(String url) {
            }
        }
    }
}

```
### Interstitial

Custom Event Class: `com.mopub.mobileads.HyperadxInterstitialMopub`

Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

> Add adapter in your project
Create package "com.mopub.mobileads" in your project and put this class in there:

```java
HyperadxInterstitialMopub.java:

package com.mopub.mobileads;
import android.content.Context;
import android.util.Log;
import com.hyperadx.lib.sdk.interstitialads.HADInterstitialAd;
import com.hyperadx.lib.sdk.interstitialads.InterstitialAdListener;
import java.util.Map;

public class HyperadxInterstitialMopub extends CustomEventInterstitial {
    private static final String PLACEMENT_KEY = "PLACEMENT";
    private HADInterstitialAd interstitialAd;
    private com.hyperadx.lib.sdk.interstitialads.Ad iAd = null;
    CustomEventInterstitialListener customEventInterstitialListener;

    @Override
    protected void loadInterstitial(final Context context, final CustomEventInterstitialListener customEventInterstitialListener, Map<String, Object> localExtras, Map<String, String> serverExtras) {
        final String placement;
        final String appId;
        if (serverExtras != null && serverExtras.containsKey(PLACEMENT_KEY)) {
            placement = serverExtras.get(PLACEMENT_KEY);

 } else {
            customEventInterstitialListener.onInterstitialFailed(MoPubErrorCode.ADAPTER_CONFIGURATION_ERROR);
            return;
        }

        interstitialAd = new HADInterstitialAd(context, placement); //Interstitial AD constructor
        interstitialAd.setAdListener(new InterstitialAdListener() { // Set Listener
            @Override
            public void onAdLoaded(com.hyperadx.lib.sdk.interstitialads.Ad ad) { // Called when AD is Loaded
                iAd = ad;
                //   Toast.makeText(context, "Interstitial Ad loaded", Toast.LENGTH_SHORT).show();
                customEventInterstitialListener.onInterstitialLoaded();
            }

            @Override
            public void onError(com.hyperadx.lib.sdk.interstitialads.Ad Ad, String error) { // Called when load is fail
                //   Toast.makeText(context, "Interstitial Ad failed to load with error: " + error, Toast.LENGTH_SHORT).show();
                customEventInterstitialListener.onInterstitialFailed(MoPubErrorCode.UNSPECIFIED);

            @Override
            public void onInterstitialDisplayed() { // Called when Ad was impressed
                //    Toast.makeText(context, "Tracked Interstitial Ad impression", Toast.LENGTH_SHORT).show();
                customEventInterstitialListener.onInterstitialShown();
            }

            @Override
            public void onInterstitialDismissed(com.hyperadx.lib.sdk.interstitialads.Ad ad) { // Called when Ad was dissnissed by user
                //   Toast.makeText(context, "Interstitial Ad Dismissed", Toast.LENGTH_SHORT).show();
                customEventInterstitialListener.onInterstitialDismissed();

            @Override
            public void onAdClicked() { // Called when user click on AD
                //   Toast.makeText(context, "Tracked Interstitial Ad click", Toast.LENGTH_SHORT).show();
                customEventInterstitialListener.onInterstitialClicked();
            }
        });

        this.customEventInterstitialListener = customEventInterstitialListener;
        interstitialAd.loadAd(); // Call to load AD

    @Override
    protected void showInterstitial() {
        if (iAd != null)
            HADInterstitialAd.show(iAd); // Call to show AD
        else
            Log.e("HADInterstitialMopub", "The Interstitial AD not ready yet. Try again!");
    }

    @Override
    protected void onInvalidate() {
    }
}
```

> This is your adapter. Now you can use Mopub as usual.

# Admob adapter

## iOS

* [Download](https://github.com/hyperads/ios-sdk/releases) and extract the HADFramework for iOS.

* You can find Admob adapter example in HyperadxiOSADs_Sample_VERSION/Mediation Adapters/AdMob/.

* First of all you need to add new app in AdMob console.

**You will get UnitId string like 'ca-app-pub-+++++++++++++/+++++++++++++'. For the next few hours you may get the AdMob errors with codes 0 or 2. Just be patient.**

![Admob 1]
(/images/adapters/ios/AdMobBanner1.png)

![Admob 2]
(/images/adapters/ios/AdMobBanner2.png)

* Then you need to add new mediation source.

![Admob 3]
(/images/adapters/ios/AdMobBanner3.png)

### Banner

* Fill `Class Name` field with a `HADCustomEventBanner`. And a `Parameter` with your HyperAdx statement string.

* Setup eCPM for new network

Now you can setting up your Xcode project.

* Put HyperAdx-SDK as described above
* Add HADCustomEventBanner.swift file

**NOTE** - In the Objective-C only project you must create swift header file as described [here](http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c)

> Just create AdMob banner Ad as usually:

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

### Interstitial

* Fill `Class Name` field with a `HADCustomEventInterstitial`. And a `Parameter` with your HyperAdx statement string.

* Setup eCPM for new network

Now you can setting up your Xcode project.

* Put HyperAdx-SDK as described above
* Add HADCustomEventInterstitial.swift file

**NOTE** - In the Objective-C only project you must create swift header file as described [here](http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c)

> Just create AdMob interstitial Ad as usually:

```swift
import GoogleMobileAds
import HADFramework
import UIKit

class ViewController: UIViewController, GADInterstitialDelegate {
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
        //Interstitial
        interstitial = GADInterstitial(adUnitID: "YOUR_ADUNIT_ID")
        interstitial.delegate = self
        interstitial.loadRequest(request)
    }

    @IBAction func createAndLoadInterstitial() {
        if interstitial.isReady {
            interstitial.presentFromRootViewController(self)
        } else {
            print("Ad wasn't ready")
        }
    }

    //MARK: GADInterstitialDelegate
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        print("interstitialDidReceiveAd")
    }

    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("interstitial didFailToReceiveAdWithError: \(error)")
    }
}
```

## Android

* [Download](https://github.com/hyperads/android-AdMob-adapter/releases) and extract the AdMob adapter if needed.

* First of all you need to add new app in AdMob console.

* You will get UnitId string like 'ca-app-pub-*************/*************'.
For the next few hours you may get the AdMob errors with codes 0 or 2. Just be patient.

Then you need to add new mediation source.

### Interstitial

* Fill `Class Name` field with a `com.hyperadx.admob.HADInterstitialEvent` string. And a `Parameter` with your HyperAdx statement string.

* Setup eCPM for new network

Now you can setting up your android project.

* Put HyperAdx-SDK and AdMob-adapter in 'libs' folder.
* Add those lines in your `build.gradle` file:

**NOTE** - Admob interstitial may not work in emulator. Use real devices even for tests!

```groove
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile 'com.android.support:appcompat-v7:23.4.0'
    compile 'com.google.android.gms:play-services-ads:9.0.2'
    compile 'com.google.android.gms:play-services-base:9.0.2'
}
```
> Just create AdMob interstitial Ad as usually:

```java
package com.hyperadx.admob_sample;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;
import com.google.android.gms.ads.AdRequest;
public class MainActivity extends AppCompatActivity {
    private com.google.android.gms.ads.InterstitialAd mAdapterInterstitial;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        loadInterstitialAd();
    }

    private void loadInterstitialAd() {
        mAdapterInterstitial = new com.google.android.gms.ads.InterstitialAd(this);
        mAdapterInterstitial.setAdUnitId(
                "ca-app-pub-6172762133617463/5529648238"
        );

        mAdapterInterstitial.setAdListener(new com.google.android.gms.ads.AdListener() {
            @Override
            public void onAdFailedToLoad(int errorCode) {
                Toast.makeText(MainActivity.this,
                        "Error loading adapter interstitial, code " + errorCode,
                        Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onAdLoaded() {
                Toast.makeText(MainActivity.this,
                        "onAdLoaded()",
                        Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onAdOpened() {
            }

            @Override
            public void onAdClosed() {
                mAdapterInterstitial.loadAd(new AdRequest.Builder().build());
            }
        });

        mAdapterInterstitial.loadAd(new AdRequest.Builder().build());
    }


    public void showInterstitial(View view) {
        if (mAdapterInterstitial.isLoaded())
            mAdapterInterstitial.show();
        else
            Toast.makeText(this, "The Interstitial AD not ready yet. Try again!", Toast.LENGTH_LONG).show();
    }
}
```
