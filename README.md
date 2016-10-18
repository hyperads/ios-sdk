![HyperADx Logo](http://d2n7xvwjxl8766.cloudfront.net/assets/site/logo-e04518160888e1f8b3795f0ce01e1909.png)

#HyperADx iOS SDK

## Getting Started

To get up and running with **HyperADx**, you'll need to [Create an Account](http://hyperadx.com/publishers/sign_in), [Add an Application to the Dashboard](http://hyperadx.com/publishers/traffic_sources) and create new Placement for it.

## Set up the SDK


* [Download](https://github.com/hyperads/ios-sdk/releases) latest release and extract the HADFramework for iOS.
* Open your project target _General_ tab.
* Drag the `HADFramework.framework` file to _Embedded Binaries_.
* Add the `AdSupport` and `CoreTelephony` frameworks to your project.

##### for Objective-C projects

* Open your project target _Build Settings_ tab.
* Set "Always Embed Swift Standard Libraries" (for Xcode 8) or "Embedded Content Contains Swift Code" (for Xcode < 8) to Yes.

##### for iOS 7
* If you want to support iOS7 - [download](https://github.com/hyperads/ios-sdk/releases/tag/v2.0.3) our legacy SDK. It supports only NativeAds.


## Ad types

* [Banner](docs/_banner.md)
* [Interstitial](docs/_interstitial.md)
* [Native](docs/_native.md)

## User segmentation events
With sending in-app events triggered by your users you can improve your monetization and get higher earnings.

Our platform automatically build audiences using your in-app data (provided by your events) and assigns high performing campaigns individually to each segment.

Also our advertisers and mediabuying department make higher bids for more engaged users.
* [Examples & events types](docs/_segments.md)

### Adapters for integration with Networks

* [MoPub](docs/_mopub.md)
* [AdMob](docs/_admob.md)
