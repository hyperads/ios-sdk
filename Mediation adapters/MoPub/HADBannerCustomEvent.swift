//
//  HADBannerCustomEvent.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

@objc(HADBannerCustomEvent)
class HADBannerCustomEvent: MPBannerCustomEvent, HADAdViewDelegate {
    
    var bannerView: HADAdView?
    
    override func requestAd(with size: CGSize, customEventInfo info: [AnyHashable : Any]!) {
        if let placementId = info["PLACEMENT"] as? String {
            
            bannerView = HADAdView(placementID: placementId, adSize:.height50Banner, viewController: delegate.viewControllerForPresentingModalView())
            bannerView?.delegate = self
            bannerView?.frame = CGRect(x:0, y:0, width:size.width, height:size.height);
            bannerView?.loadAd()
            
        } else {
            delegate.bannerCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    //MARK: HADAdViewDelegate
    
    
    func hadViewDidLoad(adView: HADAdView) {
        print("hadViewDidLoad")
        delegate.bannerCustomEvent(self, didLoadAd: adView)
    }
    
    func hadViewDidClick(adView: HADAdView) {
        print("hadViewDidClick")
        delegate.bannerCustomEventWillBeginAction(self)
    }
    
    func hadViewDidFail(adView: HADAdView, withError error: NSError?) {
        print("hadViewDidFail: \(error?.localizedDescription)")
        delegate.bannerCustomEvent(self, didFailToLoadAdWithError: error)
    }
}
