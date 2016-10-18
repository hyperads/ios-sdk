#HyperADx iOS SDK

![HyperADx Logo](http://d2n7xvwjxl8766.cloudfront.net/assets/site/logo-e04518160888e1f8b3795f0ce01e1909.png)

### Getting Started

To get up and running with HyperADx, you'll need to [Create an Account](http://hyperadx.com/publishers/sign_in), [Add an Application to the Dashboard](http://hyperadx.com/publishers/traffic_sources) and create new Placement for it.

### Set up the SDK

Follow these steps to download and include it in your project:

* [Download](https://github.com/hyperads/ios-sdk/releases) latest release and extract the HADFramework for iOS.
* Open your project target General tab.
* Drag the `HADFramework.framework` file to Embedded Binaries.
* Add the `AdSupport` and `CoreTelephony` frameworks to your project.

for Objective-C projects
* Open your project target Build Settings tab.
* Set "Always Embed Swift Standard Libraries" (for Xcode 8) or "Embedded Content Contains Swift Code" (for Xcode < 8) to Yes.

for iOS 7
* If you want to support iOS7 - download our legacy SDK. It supports only NativeAds.


### Samples

* [Banner](https://github.com/hyperads/ios-sdk/docs/_banner.md)
* [Interstitial](https://github.com/hyperads/ios-sdk/docs/_interstitial.md)
* [Native](https://github.com/hyperads/ios-sdk/docs/_native.md)
* [User segmentation](https://github.com/hyperads/ios-sdk/docs/_segments.md)

### Adapters for integration with Networks

* [MoPub](https://github.com/hyperads/ios-sdk/docs/_mopub.md)
* [AdMob](https://github.com/hyperads/ios-sdk/docs/_admob.md)
