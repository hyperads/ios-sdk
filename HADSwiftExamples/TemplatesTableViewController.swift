//
//  TableViewController.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

class TemplatesTableViewController: UITableViewController {
    var nativeAd:HADNativeAd?
    var templateType:HADNativeAdViewType?
    
    let templateNames:[HADNativeAdViewType] = [.height100,.height120,.height300,.height400]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateNames.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = HADNativeAdViewType.getName(templateNames[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        loadTemplate(templateNames[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func loadTemplate(_ type:HADNativeAdViewType){
        templateType = type
        nativeAd = HADNativeAd(placementId: "W03qNzM6")
        nativeAd?.delegate = self
        nativeAd?.loadAd()
    }
}

// MARK: - HADNativeAdDelegate
extension TemplatesTableViewController: HADNativeAdDelegate {
    func hadNativeAdDidLoad(nativeAd: HADNativeAd) {
        
        //create native ad view without customization
        //let adView:HADNativeAdView = HADNativeAdView(nativeAd:nativeAd, withType:templateType!);
        
        //create native ad view with customization
         let attributes:HADNativeAdViewAttributes = HADNativeAdViewAttributes();
         attributes.backgroundColor = UIColor.white
         attributes.buttonColor = UIColor.red
         attributes.buttonTitleColor = UIColor.white
         
         let adView:HADNativeAdView = HADNativeAdView.nativeAdView(nativeAd:nativeAd, withType:templateType!, withAttributes:attributes)
        
        //register ad view for interaction (must for click and impression processing)
        nativeAd.registerViewForInteraction(adView:adView, withViewController:self)
        
        //also you can add array of clickable views
        //nativeAd.registerViewForInteraction(adView: adView, withViewController: self, withClickableViews: [adView.ctaButton!])
        
        //create controller
        let adController = UIViewController()
        adController.view.backgroundColor = UIColor.lightGray
        adController.view.addSubview(adView)
        
        let height = HADNativeAdViewType.getSize(templateType!).height
        //set ad size
        adView.frame = CGRect(x:0, y:100, width:self.view.frame.width, height:height);
        
        //show controller with ad
        self.navigationController?.pushViewController(adController, animated: true)
    }
    
    func hadNativeAdDidClick(nativeAd: HADNativeAd) {
        print("AD CLICKED")
    }
    
    func hadNativeAdDidFail(nativeAd: HADNativeAd, withError error: NSError?) {
        print("ERROR: \(error?.localizedDescription)")
    }
}
