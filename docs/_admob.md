# Admob adapter

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

Just create AdMob banner Ad as usually:

```swift
import GoogleMobileAds
import HADFramework
import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView!

    override func viewDidLoad() {
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

Just create AdMob interstitial Ad as usually:

```swift
import GoogleMobileAds
import HADFramework
import UIKit

class ViewController: UIViewController, GADInterstitialDelegate {
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
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
