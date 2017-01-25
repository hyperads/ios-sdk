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
class HADInterstitialCustomEvent: MPInterstitialCustomEvent, HADInterstitialAdDelegate {
    
    var interstitial: HADInterstitialAd!
    
    override func requestInterstitial(withCustomEventInfo info: [AnyHashable : Any]!) {
        if let placementId = info["PLACEMENT"] as? String {
            interstitial = HADInterstitialAd(placementID: placementId)
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
    
    func hadInterstitialAdDidLoad(interstitialAd: HADInterstitialAd) {
        delegate.interstitialCustomEvent(self, didLoadAd: interstitialAd)
    }
    
    func hadInterstitialAdDidClick(interstitialAd: HADInterstitialAd) {
        delegate.interstitialCustomEventDidReceiveTap(self)
    }
    
    func hadInterstitialAdDidClose(interstitialAd: HADInterstitialAd) {
        delegate.interstitialCustomEventDidDisappear(self)
    }
    
    func hadInterstitialAdWillClose(interstitialAd: HADInterstitialAd) {
        delegate.interstitialCustomEventWillDisappear(self)
    }
    
    func hadInterstitialAdDidFail(interstitialAd: HADInterstitialAd, withError error: NSError?) {
        delegate.interstitialCustomEvent(self, didFailToLoadAdWithError: error)
    }
}
