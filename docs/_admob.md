# Admob adapter

You can configure Admob adapter to serve Hyperadx banner and interstitial ads through Admob's mediation solution. The example of Admob adapter example is located in 
[ /Mediation Adapters/Admob/](https://github.com/hyperads/ios-sdk/tree/master/Mediation%20adapters/Admob).

Please take the following steps to implement Admob adapter: 

* First, please [download](https://github.com/hyperads/ios-sdk/releases) and [install HyperADX SDK](https://github.com/hyperads/ios-sdk#set-up-the-sdk).

### Setup Admob Dashboard

* Add a new app in the AdMob dashboard.

* Add a new ad unit. Click **+NEW AD UNIT** to do this. 

![Admob-1]
(images/adapters/ios/AdMobBanner1.png)

* Select an ad format and enter the relevant details.

![Admob-2]
(images/adapters/ios/AdMobBanner2.png)

* Then add a new mediation source. Select your application from the **All apps** list on the left-hand side. Click the link in the **Mediation** column to the right of the ad unit you want to modify. Click **+ New APP NETWORK.** Add the custom event: 

![Admob-3]
(images/adapters/ios/AdMobBanner3.png)

* You will get UnitId string like 'ca-app-pub-+++++++++++++/+++++++++++++'. For the next few hours you may get the AdMob errors with codes 0 or 2 with text "No ad to show.". Just be patient.

### Banner

Specify the following values for the fields:

* `Class Name`:  `HADCustomEventBanner`.
* `Label`: Specify a name for yout custom event that will be used in reporting
* `Parameter`:  specify your HyperADX statement string. You can use the test placement `5b3QbMRQ`

* Setup eCPM for new network

Now you can set up your Xcode project.

* [Install HyperADX SDK](https://github.com/hyperads/ios-sdk#set-up-the-sdk) as described above
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

Specify the following values for the fields:

* `Class Name`:  `HADCustomEventInterstitial`.
* `Label`: Specify a name for yout custom event that will be used in reporting
* `Parameter`:  specify your HyperADX statement string. You can use the test placement `5b3QbMRQ`

* Setup eCPM for new network

Now you can set up your Xcode project.

* [Install HyperADX SDK](https://github.com/hyperads/ios-sdk#set-up-the-sdk) as described above
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
