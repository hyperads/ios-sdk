//
//  ViewController.swift
//  ADFrameworkApp
//
//  Created by Mihael Isaev on 22/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import HADFramework

class ViewController: UIViewController, HADInterstitialDelegate {
    @IBAction func createInterstitialController() {
        let interstitial = HADInterstitial(placementId: "5b3QbMRQ")
        interstitial.delegate = self
        interstitial.loadAd()
    }
    
    //MARK: HADInterstitial Delegate
    
    func HADInterstitialDidLoad(controller: HADInterstitial) {
        controller.modalTransitionStyle = .coverVertical
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    func HADInterstitialDidClick(controller: HADInterstitial) {
        print("HADInterstitialDidClick")
    }
    
    func HADInterstitialDidClose(controller: HADInterstitial) {
        print("HADInterstitialDidClose")
    }
    
    func HADInterstitialWillClose(controller: HADInterstitial) {
        print("HADInterstitialWillClose")
    }
    
    func HADInterstitialDidFail(controller: HADInterstitial, error: NSError?) {
        print("ERROR: \(error?.localizedDescription)")
    }
}

