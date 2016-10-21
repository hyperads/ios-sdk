# Mopub Adapter

* [Download](https://github.com/hyperads/ios-sdk/releases) and extract the HADFramework for iOS.

* You can find Mopub adapter example in HyperadxiOSADs_Sample_VERSION/Mediation Adapters/MoPub/.

Setup SDKs:

* [Integrate](https://github.com/mopub/mopub-ios-sdk/wiki/Manual-Native-Ads-Integration-for-iOS) with Mopub SDK
* Install Hyperadx SDK

**NOTE** - In the Objective-C only project you must create swift header file as described [here](http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c)

### Setup Mopub Dashboard

* Create an "Hyperadx" Network in Mopub's dashboard and connect it to your Ad Units. In Mopub's dashboard select Networks > Add New network

![Mopub-1]
(images/adapters/ios/mopub1.png)

* Then select Custom Native Network

![Mopub-2]
(images/adapters/ios/mopub2.png)

* Complete the fields accordingly to the Ad Unit that you want to use

![Mopub-3]
(images/adapters/ios/mopub3.png)

### Native ads

* Add HADNativeAdAdapter.swift and HADNativeCustomEvent.swift files
* Custom Event Class: `HADNativeCustomEvent`
* Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

Add `HADNativeCustomEvent.swift` and `HADNativeAdAdapter.swift` adapter files in your project
Implement MoPub NativeViewController:

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

And implement MoPubNativeAdRenderer, e.g.:

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

Add `HADInterstitialCustomEvent.swift` adapter in your project. Implement MoPub Interstitial:

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

Add `HADBannerCustomEvent.swift` adapter in your project
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

This is your adapter. Now you can use Mopub as usual.
