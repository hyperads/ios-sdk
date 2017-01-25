//
//  HADCustomEventBanner.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import GoogleMobileAds
import HADFramework

@objc(HADCustomEventBanner)
class HADCustomEventBanner: NSObject, GADCustomEventBanner, HADAdViewDelegate {
    
    var delegate: GADCustomEventBannerDelegate?
    
    //MARK: GADCustomEventBanner
    
    func requestAd(_ adSize: GADAdSize, parameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        
        let bannerView = HADAdView(placementID: serverParameter!, adSize:.height50Banner, viewController: delegate?.viewControllerForPresentingModalView)
        bannerView.loadAd()
        bannerView.delegate = self
        
        bannerView.frame = CGRect(x:0, y:0, width:adSize.size.width, height:adSize.size.height);
    }
    
    //MARK: HADAdViewDelegate
    
    func hadViewDidLoad(adView: HADAdView) {
        print("hadViewDidLoad")
        delegate?.customEventBanner(self, didReceiveAd: adView)
    }
    
    func hadViewDidClick(adView: HADAdView) {
        print("hadViewDidClick")
        delegate?.customEventBannerWasClicked(self)
    }
    
    func hadViewDidFail(adView: HADAdView, withError error: NSError?) {
        print("hadViewDidFail: \(error?.localizedDescription)")
        delegate?.customEventBanner(self, didFailAd: error)
    }
}
