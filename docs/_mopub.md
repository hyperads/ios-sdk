# Mopub Adapter

You can configure MoPub adapter to serve Hyperadx native, banner and interstitial ads through MoPub's mediation solution. The example of  Mopub adapter example is located in
[ /Mediation Adapters/MoPub/](https://github.com/hyperads/ios-sdk/tree/master/Mediation%20adapters/MoPub).

Please take the following steps to implement MoPub adapter: 

* [Download](https://github.com/hyperads/ios-sdk/releases) and extract the HADFramework for iOS.


Setup SDKs:

* [Integrate](https://github.com/mopub/mopub-ios-sdk/wiki/Manual-Native-Ads-Integration-for-iOS) with Mopub SDK.
* [Install HyperADX SDK](https://github.com/hyperads/ios-sdk#set-up-the-sdk).

**NOTE** In Objective-C projects you will need to create a Swift header file as described [here.](http://stackoverflow.com/questions/24102104/how-to-import-swift-code-to-objective-c)

### Setup Mopub Dashboard

* Create the "HyperADX" Network in Mopub's dashboard and connect the network to your Ad Units. 

Log into MoPub.

In Mopub's dashboard select **Networks > Add a Network.**

<img src="/docs/images/adapters/ios/mopub1.png" title="sample" width="808" height="248" />

* Then select **Custom Native Network.**

<img src="/docs/images/adapters/ios/mopub2.png" title="sample" width="1020" height="543" />

* Fill in the fields accordingly to the Ad Unit that you want to use.

<img src="/docs/images/adapters/ios/mopub3.png" title="sample" width="1020" height="800" />

### Interstitial

For Interstitial ads specify the following values for the fields:

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
        interstitial.show(from: self)
    }

    func interstitialDidFailToLoadAd(inter: MPInterstitialAdController!) {
        print("interstitialDidFailToLoadAd")
    }
}
```

### Banner

For Banner ads specify the following values for the fields:

* Custom Event Class: `HADBannerCustomEvent`

* Custom Event Class Data: `{"PLACEMENT":"<YOUR PLACEMENT>"}`

**You can use the test placement `5b3QbMRQ`**

Add `HADBannerCustomEvent.swift` adapter in your project. Implement MoPub Banner:

```swift
import HADFramework
import UIKit

class ViewController: UIViewController, MPAdViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Banner 320x50
        let m = MPAdView(adUnitId: "YOUR_AD_UNIT", size: CGSize(width: 320, height: 50))
        m.delegate = self
        m.frame = CGRectMake(x: (UIScreen.main.bounds.width-320)/2, y: 100, width: 320, height: 50)
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
