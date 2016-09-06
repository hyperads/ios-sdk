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
class HADBannerCustomEvent: MPBannerCustomEvent, HADBannerViewDelegate {
    override func requestAdWithSize(size: CGSize, customEventInfo info: [NSObject : AnyObject]!) {
        if let placementId = info["placementId"] as? String {
            let m = HADBannerView(frame: CGRectMake(0, 0, size.width, size.height))
            m.loadAd(placementId, bannerSize: HADBannerSize.Height50, delegate: self)
        } else {
            delegate.bannerCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    //MARK: HADBannerViewDelegate
    
    func HADViewDidLoad(view: HADBannerView) {
        delegate.bannerCustomEvent(self, didLoadAd: view)
    }
    
    func HADView(view: HADBannerView, didFailWithError error: NSError?) {
        delegate.bannerCustomEvent(self, didFailToLoadAdWithError: error)
    }
    
    func HADViewDidClick(view: HADBannerView) {
        delegate.bannerCustomEventWillBeginAction(self)
    }
}