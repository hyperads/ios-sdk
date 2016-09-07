//
//  HADInterstitialCustomEvent.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

@objc(HADInterstitialCustomEvent)
class HADInterstitialCustomEvent: MPInterstitialCustomEvent, HADInterstitialDelegate {
    var interstitial: HADInterstitial!
    override func requestInterstitial(withCustomEventInfo info: [AnyHashable : Any]!) {
        if let placementId = info["placementId"] as? String {
            interstitial = HADInterstitial(placementId: placementId)
            interstitial.delegate = self
            interstitial.loadAd()
        } else {
            delegate.interstitialCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    override func showInterstitial(fromRootViewController rootViewController: UIViewController!) {
        delegate.interstitialCustomEventWillAppear(self)
        interstitial.modalTransitionStyle = .coverVertical
        interstitial.modalPresentationStyle = .fullScreen
        rootViewController.present(interstitial, animated: true, completion: nil)
    }
    
    //MARK: HADInterstitial Delegate
    
    func HADInterstitialDidLoad(controller: HADInterstitial) {
        delegate.interstitialCustomEvent(self, didLoadAd: controller)
    }
    
    func HADInterstitialDidClick(controller: HADInterstitial) {
        delegate.interstitialCustomEventDidReceiveTap(self)
    }
    
    func HADInterstitialDidClose(controller: HADInterstitial) {
        delegate.interstitialCustomEventDidDisappear(self)
    }
    
    func HADInterstitialWillClose(controller: HADInterstitial) {
        delegate.interstitialCustomEventWillDisappear(self)
    }
    
    func HADInterstitialDidFail(controller: HADInterstitial, error: NSError?) {
        delegate.interstitialCustomEvent(self, didFailToLoadAdWithError: error)
    }
}
