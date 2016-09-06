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
    
    override func requestInterstitialWithCustomEventInfo(info: [NSObject : AnyObject]!) {
        if let placementId = info["placementId"] as? String {
            interstitial = HADInterstitial(placementId: placementId)
            interstitial.delegate = self
            interstitial.loadAd()
        } else {
            delegate.interstitialCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
        }
    }
    
    override func showInterstitialFromRootViewController(rootViewController: UIViewController!) {
        delegate.interstitialCustomEventWillAppear(self)
        interstitial.modalTransitionStyle = .CoverVertical
        interstitial.modalPresentationStyle = .FullScreen
        rootViewController.presentViewController(interstitial, animated: true, completion: nil)
    }
    
    //MARK: HADInterstitial Delegate
    
    func HADInterstitialDidLoad(controller: HADInterstitial) {
        delegate.interstitialCustomEvent(self, didLoadAd: controller)
    }
    
    func HADInterstitialDidClick(controller: HADInterstitial) {
        delegate.interstitialCustomEventDidReceiveTapEvent(self)
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