//
//  HADCustomEventInterstitial.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import GoogleMobileAds
import HADFramework

@objc(HADCustomEventInterstitial)
class HADCustomEventInterstitial: NSObject, GADCustomEventInterstitial, HADInterstitialDelegate {
    
    var delegate: GADCustomEventInterstitialDelegate?
    var interstitial: HADInterstitial!
    
    //MARK: GADCustomEventInterstitial
    
    func requestInterstitialAdWithParameter(serverParameter: String!, label serverLabel: String!, request: GADCustomEventRequest!) {
        interstitial = HADInterstitial(placementId: serverParameter)
        interstitial.delegate = self
        interstitial.loadAd()
    }
    
    func presentFromRootViewController(rootViewController: UIViewController!) {
        delegate?.customEventInterstitialWillPresent(self)
        interstitial.modalTransitionStyle = .CoverVertical
        interstitial.modalPresentationStyle = .FullScreen
        rootViewController.presentViewController(interstitial, animated: true, completion: nil)
    }
    
    //MARK: HADInterstitial Delegate
    
    func HADInterstitialDidLoad(controller: HADInterstitial) {
        delegate?.customEventInterstitialDidReceiveAd(self)
    }
    
    func HADInterstitialDidClick(controller: HADInterstitial) {
        delegate?.customEventInterstitialWasClicked(self)
    }
    
    func HADInterstitialDidClose(controller: HADInterstitial) {
        delegate?.customEventInterstitialDidDismiss(self)
    }
    
    func HADInterstitialWillClose(controller: HADInterstitial) {
        delegate?.customEventInterstitialWillDismiss(self)
    }
    
    func HADInterstitialDidFail(controller: HADInterstitial, error: NSError?) {
        delegate?.customEventInterstitial(self, didFailAd: error)
    }
}