//
//  HADCustomEventInterstitial.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import GoogleMobileAds
import HADFramework

@objc(HADCustomEventInterstitial)
class HADCustomEventInterstitial: NSObject, GADCustomEventInterstitial, HADInterstitialAdDelegate {
    
    var delegate: GADCustomEventInterstitialDelegate?
    var interstitial: HADInterstitialAd!
    
    //MARK: GADCustomEventInterstitial
    func requestAd(withParameter serverParameter: String?, label serverLabel: String?, request: GADCustomEventRequest) {
        interstitial = HADInterstitialAd(placementID: serverParameter!)
        interstitial.delegate = self
        interstitial.loadAd()
    }
    
    func present(fromRootViewController rootViewController: UIViewController) {
        delegate?.customEventInterstitialWillPresent(self)
        interstitial.modalTransitionStyle = .coverVertical
        interstitial.modalPresentationStyle = .fullScreen
        rootViewController.present(interstitial, animated: true, completion: nil)
    }
    
    //MARK: HADInterstitial Delegate
    
    func hadInterstitialAdDidLoad(interstitialAd: HADInterstitialAd) {
        delegate?.customEventInterstitialDidReceiveAd(self)
    }
    
    func hadInterstitialAdDidClick(interstitialAd: HADInterstitialAd) {
        delegate?.customEventInterstitialWasClicked(self)
    }
    
    func hadInterstitialAdDidClose(interstitialAd: HADInterstitialAd) {
        delegate?.customEventInterstitialDidDismiss(self)
    }
    
    func hadInterstitialAdWillClose(interstitialAd: HADInterstitialAd) {
        delegate?.customEventInterstitialWillDismiss(self)
    }
    
    func hadInterstitialAdDidFail(interstitialAd: HADInterstitialAd, withError error: NSError?) {
        delegate?.customEventInterstitial(self, didFailAd: error)
    }
}
