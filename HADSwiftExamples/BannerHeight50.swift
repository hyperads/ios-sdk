//
//  BannerHeight50.swift
//  HADFramework
//
//  Created by Mihael Isaev on 22/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import HADFramework

class BannerHeight50: UIViewController, HADBannerViewDelegate {
    @IBOutlet weak var bannerView: HADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.loadAd("5b3QbMRQ", bannerSize: .Height50, delegate: self)
    }
    
    func HADViewDidLoad(view: HADBannerView) {
        print("AD LOADED")
    }
    
    func HADViewDidClick(view: HADBannerView) {
        print("CLICKED AD")
    }
    
    func HADView(view: HADBannerView, didFailWithError error: NSError?) {
        print("ERROR: %@", error?.localizedDescription)
    }
}