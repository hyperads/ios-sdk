//
//  HADNativeAdAdapter.swift
//  HADFramework
//
//  Created by Mihael Isaev on 11/07/16.
//  Copyright © 2016 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

@objc(HADNativeAdAdapter)
class HADNativeAdAdapter: NSObject, MPNativeAdAdapter {
    public var properties: [AnyHashable : Any]!
    var defaultActionURL: URL!
    var delegate: MPNativeAdAdapterDelegate!
    
    var nativeAd: HADNativeAd!
    
    init (nativeAd: HADNativeAd) {
        self.nativeAd = nativeAd
    }
    
    func enableThirdPartyClickTracking() -> Bool {
        return true
    }
    
    func willAttach(to view: UIView!) {
        if let nativeAdRendering = delegate.viewControllerForPresentingModalView() as? MPNativeAdRendering {
            nativeAdRendering.nativeTitleTextLabel?().text = nativeAd.title
            nativeAdRendering.nativeMainTextLabel?().text = nativeAd.desc
            nativeAdRendering.nativeCallToActionTextLabel?().text = nativeAd.cta
            nativeAd.loadBanner(into: nativeAdRendering.nativeMainImageView!(), animated: true)
            nativeAd.loadIcon(into: nativeAdRendering.nativeIconImageView!(), animated: true)
            delegate.viewControllerForPresentingModalView().view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(trackClick)))
        }
    }
    
    func privacyInformationIconView() -> UIView! {
        return UIView()
    }
    
    func mainMediaView() -> UIView! {
        return UIView()
    }
    
    func trackClick() {
        nativeAd.handleClick()
    }
}
