//
//  HADNativeCustomEvent.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

@objc(HADNativeCustomEvent)
class HADNativeCustomEvent: MPNativeCustomEvent, HADNativeAdDelegate {
    var nativeAd: HADNativeAd!
    
    override func requestAdWithCustomEventInfo(info: [NSObject : AnyObject]!) {
        if let placementId = info["placementId"] as? String {
            let nativeAd = HADNativeAd(placementId: placementId, bannerSize: .Block300x250, delegate: self)
            nativeAd.loadAd()
        } else {
            delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    //MARK: HADNativeAdDelegate Delegate
    
    func HADNativeAdDidLoad(nativeAd: HADNativeAd) {
        let adAdapter = HADNativeAdAdapter(nativeAd: nativeAd)
        let interfaceAd = MPNativeAd(adAdapter: adAdapter)
        delegate.nativeCustomEvent(self, didLoadAd: interfaceAd)
    }
    
    func HADNativeAdDidFail(nativeAd: HADNativeAd, error: NSError) {
        delegate.nativeCustomEvent(self, didFailToLoadAdWithError: error)
    }
}