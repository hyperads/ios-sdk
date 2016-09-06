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
        bannerTemplateView.loadAd("5b3QbMRQ", bannerTemplate: .BlockTwo, delegate: self)
        //And customize everything
        bannerTemplateView.customBackgroundColor = UIColor.lightGrayColor()
        bannerTemplateView.customTitleTextColor = UIColor.blueColor()
        bannerTemplateView.customPoweredByTextColor = UIColor.lightGrayColor()
        bannerTemplateView.customDescriptionTextColor = UIColor.darkGrayColor()
        bannerTemplateView.customIconCornerRadius = 6
        bannerTemplateView.customButtonBackgroundColor = UIColor.clearColor()
        bannerTemplateView.customButtonBorderColor = UIColor.purpleColor()
        bannerTemplateView.customButtonBorderWidth = 1
        bannerTemplateView.customButtonTitleColor = UIColor.purpleColor()
        bannerTemplateView.customButtonCornerRadius = 6
        bannerTemplateView.customBannerCornerRadius = 6
        bannerTemplateView.customStarRatingFilledColor = UIColor.greenColor()
        bannerTemplateView.customStarRatingEmptyColor = UIColor.purpleColor()
        bannerTemplateView.customStarRatingTextColor = UIColor.purpleColor()
        bannerTemplateView.customClickMode = .Button
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