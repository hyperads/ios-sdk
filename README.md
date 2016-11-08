![HyperADx Logo](http://d2n7xvwjxl8766.cloudfront.net/assets/site/logo-e04518160888e1f8b3795f0ce01e1909.png)

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

* [Download](https://github.com/hyperads/ios-sdk/releases) latest release and extract the HADFramework for iOS.
* Open your project target _General_ tab.
* Drag the `HADFramework.framework` file to _Embedded Binaries_. Make sure **Copy items if needed** is selected.
* Add the `AdSupport` and `CoreTelephony` frameworks to your project.
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

You can implement the following ad formats for your iOS application:

* [Banner](docs/_banner.md)
* [Interstitial](docs/_interstitial.md)
* [Native](docs/_native.md)

## User segmentation events

With sending in-app events triggered by your users you can improve your monetization and get higher earnings.

HyperADX automatically builds audiences using your in-app data (provided by the events) and assigns high performing campaigns individually to each segment.

Also, our advertisers and media buying department make higher bids for more engaged users.

* [Examples & event types](docs/_segments.md)

### Adapters for integration with popular Networks

HyperADX provides MoPub and AdMob adapters for iOS applications. Publishers using MoPub and AdMob to mediate ad networks for their iOS apps can now take advantage of serving Hypeadx's native (MoPub only), interstitia and banner ads through MoPub's and AdMob's mediation solutions.
The sections below will let you know how to add the network adapter.

* [MoPub](docs/_mopub.md)
* [AdMob](docs/_admob.md)















