//
//  NativeTemplateFour.swift
//  HADFramework
//
//  Created by Mihael Isaev on 13/07/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import Foundation
import HADFramework

class NativeTemplateBlockTwo: UIViewController, HADBannerTemplateViewDelegate {
    @IBOutlet weak var bannerTemplateView: HADBannerTemplateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Just set HADBannerTemplateTypes param in loadAd method
        bannerTemplateView.loadAd(placementId: "5b3QbMRQ", bannerTemplate: .blockTwo, delegate: self)
        //And customize everything
        bannerTemplateView.customBackgroundColor = UIColor.lightGray
        bannerTemplateView.customTitleTextColor = UIColor.blue
        bannerTemplateView.customPoweredByTextColor = UIColor.lightGray
        bannerTemplateView.customDescriptionTextColor = UIColor.darkGray
        bannerTemplateView.customIconCornerRadius = 6
        bannerTemplateView.customButtonBackgroundColor = UIColor.clear
        bannerTemplateView.customButtonBorderColor = UIColor.purple
        bannerTemplateView.customButtonBorderWidth = 1
        bannerTemplateView.customButtonTitleColor = UIColor.purple
        bannerTemplateView.customButtonCornerRadius = 6
        bannerTemplateView.customBannerCornerRadius = 6
        bannerTemplateView.customStarRatingFilledColor = UIColor.green
        bannerTemplateView.customStarRatingEmptyColor = UIColor.purple
        bannerTemplateView.customStarRatingTextColor = UIColor.purple
        bannerTemplateView.customClickMode = .button
    }
    
    func HADTemplateViewDidLoad(view: HADBannerTemplateView) {
        print("AD LOADED")
    }
    
    func HADTemplateViewDidClick(view: HADBannerTemplateView) {
        print("CLICKED AD")
    }
    
    func HADTemplateView(view: HADBannerTemplateView, didFailWithError error: NSError?) {
        print("ERROR: %@", error?.localizedDescription)
    }
}
