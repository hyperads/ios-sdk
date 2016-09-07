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
    override func requestAd(with size: CGSize, customEventInfo info: [AnyHashable : Any]!) {
        if let placementId = info["placementId"] as? String {
            let m = HADBannerView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            m.loadAd(placementId: placementId, bannerSize: HADBannerSize.height50, delegate: self)
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
