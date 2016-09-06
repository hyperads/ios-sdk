//
//  NativeAd.swift
//  HADFramework
//
//  Created by Mihael Isaev on 22/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import HADFramework

class NativeAd: UIViewController, HADNativeAdDelegate {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var imageView: HADMediaView!
    @IBOutlet weak var iconView: HADMediaView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cta: UIButton?
    
    var nativeAd: HADNativeAd! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nativeAd = HADNativeAd(placementId: "5b3QbMRQ", delegate: self)
        nativeAd.loadAd()
    }
    
    //MARK: HADNativeAd Delegate
    
    func HADNativeAdDidLoad(nativeAd: HADNativeAd) {
        imageView.loadHADBanner(nativeAd, animated: true) { (error, image) in
            if error != nil {
                print("ERROR: CAN'T DOWNLOAD BANNER \(error)")
                return
            }
            print("BANNER DOWNLOADED")
        }
        iconView.loadHADIcon(nativeAd, animated: true) { (error, image) in
            if error != nil {
                print("ERROR: CAN'T DOWNLOAD ICON \(error)")
                return
            }
            print("ICON DOWNLOADED")
        }
        titleLabel.text = nativeAd.title
        descLabel.text = nativeAd.desc
        cta?.setTitle(nativeAd.cta, forState: .Normal)
    }
    
    @IBAction func adClicked() {
        nativeAd.handleClick()
    }
    
    func HADNativeAdDidClick(nativeAd: HADNativeAd) {
        print("CLICKED AD")
    }
    
    func HADAd(nativeAd: HADNativeAd, didFailWithError error: NSError) {
        print("ERROR: \(error.localizedDescription)")
    }
}