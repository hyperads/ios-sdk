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
    
    override func requestAd(withCustomEventInfo info: [AnyHashable : Any]!) {
        if let placementId = info["placementId"] as? String {
            let nativeAd = HADNativeAd(placementId: placementId, delegate: self)
            nativeAd.loadAd()
        } else {
            delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    //MARK: HADNativeAdDelegate Delegate
    
    func HADNativeAdDidLoad(nativeAd: HADNativeAd) {
        let adAdapter = HADNativeAdAdapter(nativeAd: nativeAd)
        let interfaceAd = MPNativeAd(adAdapter: adAdapter)
        delegate.nativeCustomEvent(self, didLoad: interfaceAd)
    }
    
    func HADNativeAdDidFail(nativeAd: HADNativeAd, error: NSError) {
        delegate.nativeCustomEvent(self, didFailToLoadAdWithError: error)
    }
}
