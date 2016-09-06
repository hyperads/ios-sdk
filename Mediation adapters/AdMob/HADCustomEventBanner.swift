//
//  HADCustomEventBanner.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import GoogleMobileAds
import HADFramework

@objc(HADCustomEventBanner)
class HADCustomEventBanner: NSObject, GADCustomEventBanner, HADBannerViewDelegate {
    
    var delegate: GADCustomEventBannerDelegate?
    
    //MARK: GADCustomEventBanner
    
    func requestBannerAd(adSize: GADAdSize, parameter: String, label: String, request: GADCustomEventRequest) {
        let bannerView = HADBannerView(frame: CGRectMake(0, 0, adSize.size.width, adSize.size.height))
        bannerView.loadAd(parameter, bannerSize: HADBannerSize.Height50, delegate: self)
    }
    
    //MARK: HADBannerViewDelegate
    
    func HADViewDidLoad(view: HADBannerView) {
        delegate?.customEventBanner(self, didReceiveAd: view)
    }
    
    func HADView(view: HADBannerView, didFailWithError error: NSError?) {
        delegate?.customEventBanner(self, didFailAd: error)
    }
    
    func HADViewDidClick(view: HADBannerView) {
        delegate?.customEventBannerWasClicked(self)
    }
}