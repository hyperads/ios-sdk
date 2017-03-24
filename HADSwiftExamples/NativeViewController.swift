//
//  NativeAd.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

class NativeViewController: UIViewController {
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var mediaView: HADMediaView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    var nativeAd: HADNativeAd! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nativeAd = HADNativeAd(placementId: "W03qNzM6")
        nativeAd.delegate = self
        
        //optionaly set cache policy
        nativeAd.mediaCachePolicy = .all;
        
        //optionaly set custom params
        let adRequest = HADAdRequest()
        adRequest.setCustomParams(params: ["fooKey":"fooValue","barKey":"barValue"])
        adRequest.setAge(value: 33)
        adRequest.setKeywords(value: "one,two,free")
        adRequest.setCustomParam(key: "hy", value: "per")
        nativeAd.adRequest = adRequest
        
        nativeAd.loadAd()
    }
    
    deinit {
        print("native vc deinit")
    }
}

extension NativeViewController: HADNativeAdDelegate {
    func hadNativeAdDidLoad(nativeAd: HADNativeAd) {
        
        print("hadNativeAdDidLoad")
        
        if self.nativeAd != nil {
            self.nativeAd.unregisterView()
        }
        
        self.nativeAd = nativeAd
        
        // Wire up UIView with the native ad; the whole UIView will be clickable.
        self.nativeAd.registerViewForInteraction(adView:adView, withViewController:self)
        
        //you can specify clickable views like:
        //self.nativeAd.registerViewForInteraction(adView: self.adView, withViewController: self, withClickableViews: [descLabel, iconImageView, ctaButton])
        
        // Create native UI using the ad metadata.
        
        mediaView.setNativeAd(nativeAd: self.nativeAd)
        
        self.nativeAd.icon?.loadImageAsyncWithBlock(){ [weak self] (error, image) in
            if error != nil {
                print("ERROR: CAN'T DOWNLOAD ICON \(error)")
                return
            }
            
            self?.iconImageView.image = image
            print("ICON DOWNLOADED")
        }
        
        titleLabel.text = self.nativeAd.title
        descLabel.text = self.nativeAd.body
        ctaButton.setTitle(self.nativeAd.callToAction, for: .normal)
        ctaButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    
    func hadNativeAdDidClick(nativeAd: HADNativeAd) {
        print("hadNativeAdDidClick")
    }
    
    func hadNativeAdDidFail(nativeAd: HADNativeAd, withError error: NSError?) {
        print("hadNativeAdDidFail: \(error?.localizedDescription)")
    }
}
