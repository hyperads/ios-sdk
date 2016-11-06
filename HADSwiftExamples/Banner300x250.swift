//
//  Banner300x250.swift
//  HADFramework
//
//  Created by Mihael Isaev on 22/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import HADFramework

class Banner300x250: UIViewController, HADBannerViewDelegate {
    @IBOutlet weak var bannerView: HADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.loadAd(placementId: "5b3QbMRQ", bannerSize: .block300x250, delegate: self)
    }
    
    func HADViewDidLoad(view: HADBannerView) {
        print("AD LOADED")
    }
    
    func HADViewDidClick(view: HADBannerView) {
        print("CLICKED AD")
    }
    
    func HADView(view: HADBannerView, didFailWithError error: NSError?) {
        print("ERROR: \(error?.localizedDescription)")
    }
}
