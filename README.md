[![HyperADx Logo](http://d2n7xvwjxl8766.cloudfront.net/assets/site/logo-e04518160888e1f8b3795f0ce01e1909.png)](http://hyperadx.com)

## HyperADX iOS SDK

Hyper is a leading monetization and advertising platform, which enables its partners and clients to use all the power of native advertising.

## Getting Started

To get up and running with **HyperADX**, you'll need to [Create an Account](http://hyperadx.com/publishers/sign_in), [Add an Application to the Dashboard](http://hyperadx.com/publishers/traffic_sources) and create one or more Placements for your added application.


## Requirements

The following platforms and environments are supported:

* iOS 8.0+
* Xcode 8+
* Swift 3

## Set up the SDK

Please complete the steps listed below to download and set-up HADFramework - Hyper SDK for iOS.

* [Download](https://github.com/hyperads/ios-sdk/releases) the latest release and extract the HADFramework for iOS.
* Open your project target _General_ tab.
* Drag the `HADFramework.framework` file to _Embedded Binaries_. Make sure **Copy items if needed** is selected.
* Add the `AdSupport`, `CoreTelephony` and `AVFoundation` frameworks to your project.
* Create a new _Run Script Phase_ in your app target _Build Phases_ and paste the following snippet in the script text field:
```
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/HADFramework.framework/strip-frameworks.sh"
```
This step is required to work around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) when archiving universal binaries.

##### for Objective-C projects:

* Open your project target _Build Settings_ tab.
* Set **Always Embed Swift Standard Libraries** to **Yes**.

##### for iOS 7:
* If you want to support iOS7 - [download](https://github.com/hyperads/ios-sdk/releases/tag/v2.0.4) our legacy SDK. It only supports Native ads type.


## Supported Ad types

You can implement the following ad formats in your iOS application:

* [Native & Native video](docs/_native.md)
* [Interstitial](docs/_interstitial.md)
* [Video Interstitial](docs/_video.md)
* [Video Rewarded](docs/_rewarded.md)
* [Banner](docs/_html.md)

### Targeting

Ad users are different in their behaviors, needs and expectations. Applying user segmentation delivers the best-fitting ad experience to your users. Custom ad targeting results in increasing your monetization values and obtaining maximum value from every user. Besides our advertisers and media buying department encourage the most engaged users by making higher bids for them.
 
* [Examples & target types](docs/_target.md)
 
### User segmentation
 
Customer segmentation is the practice of dividing a customer base into groups of individuals that are similar in specific ways relevant to marketing, such as age, gender, interests and spending habits. You can build custom (or use predefined) segments from your users. This is potentially increase your monetization.

* [Examples](docs/_events.md)
 
### Adapters for integration with popular Networks

HyperADX provides MoPub and AdMob adapters for iOS applications. Publishers using MoPub and AdMob to mediate ad networks for their iOS apps can now take advantage of serving HypeADX's, interstitial and banner ads through MoPub's and AdMob's mediation solutions.

The sections below will let you know how to add the network adapter.

* [MoPub](docs/_mopub.md)
* [AdMob](docs/_admob.md)















