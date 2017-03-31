//
//  ViewController.swift
//  ADFrameworkApp
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionRows[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = sectionRows[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        adSelected(sectionRows[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var preloaderView: UIView!
    
    var sectionNames = ["Native", "Banners", "Interstitial"]
     var sectionRows = [["Native Ad", "TableView with Native Ads", "CollectionView with Native Ads", "Native Ads Templates"],["Banner 300x250", "TableView with Banner Ads", "CollectionView with Banner Ads"],["Interstitial", "Video Interstitial"]]
    
    var interstitialAd:HADInterstitialAd?
    var videoInterstitialAd:HADVideoInterstitialAd?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        preloaderView.isHidden = true
        
        //User's event test
        HADEventManager.sharedInstance.setup(token: "TOKEN")
        HADEventManager.sharedInstance.send(type: .invite)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
    
    func adSelected(_ adName:String){
        
        switch adName {
        case "Native Ad":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "TableView with Native Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "CollectionView with Native Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Native Ads Templates":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Banner 300x250":
            showBanner(size: .banner300x250)
            break
        case "TableView with Banner Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "CollectionView with Banner Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Interstitial":
            showInterstitial()
            break
        case "Video Interstitial":
            showVideoInterstitial()
            break
        default:
            print("Error: Ad not found")
        }
    }
    
    func showInterstitial() {
        preloaderView.isHidden = false
        interstitialAd = HADInterstitialAd(placementID: "W93593Xw")
        interstitialAd?.delegate = self
        
        //optionaly set custom params
        let adRequest = HADAdRequest()
        adRequest.setKeywords(value: "one,two,free")
        interstitialAd?.adRequest = adRequest
        
        interstitialAd?.loadAd()
    }
    
    func showVideoInterstitial() {
        preloaderView.isHidden = false
        videoInterstitialAd = HADVideoInterstitialAd(placementID: "kvaXVl3r")
        videoInterstitialAd?.delegate = self
        
        //optionaly set custom params
        let adRequest = HADAdRequest()
        adRequest.setKeywords(value: "one,two,free")
        videoInterstitialAd?.adRequest = adRequest
        
        videoInterstitialAd?.loadAd()
    }
    
    func showBanner(size:HADBannerAdSize) {
        let bannerView = HADBannerAd(placementID: "KoMrp58X", bannerSize:size, viewController: self)
        bannerView.delegate = self
        
        //optionaly set custom params
        let adRequest = HADAdRequest()
        adRequest.setKeywords(value: "one,two,free")
        bannerView.adRequest = adRequest
        
        bannerView.loadAd()
        
        //create controller
        let adController = UIViewController()
        adController.view.backgroundColor = UIColor.lightGray
        adController.view.addSubview(bannerView)
        
        //set ad size
        bannerView.frame = CGRect(x:0, y:100, width:self.view.frame.width, height:HADBannerAdSize.getSize(size).height)
        
        //show controller with ad
        self.navigationController?.pushViewController(adController, animated: true)
    }
}

// MARK: - HADBannerAdDelegate
extension MainViewController: HADBannerAdDelegate {
    func hadBannerAdDidLoad(bannerAd: HADBannerAd) {
        print("hadBannerAdDidLoad")
    }
    
    func hadBannerAdDidClick(bannerAd: HADBannerAd) {
        print("hadBannerAdDidClick")
    }
    
    func hadBannerAdWillLogImpression(bannerAd: HADBannerAd) {
        print("hadBannerAdWillLogImpression")
    }
    
    func hadBannerAdDidFail(bannerAd: HADBannerAd, withError error: NSError?) {
        print("hadBannerAdDidFail \(error)")
    }
}

// MARK: - HADAdViewDelegate
extension MainViewController: HADAdViewDelegate {
    func hadViewDidLoad(adView: HADAdView) {
        print("hadViewDidLoad")
    }
    
    func hadViewDidClick(adView: HADAdView) {
        print("hadViewDidClick")
    }
    
    func hadViewDidFail(adView: HADAdView, withError error: NSError?) {
        print("hadViewDidFail: \(error?.localizedDescription)")
    }
}

// MARK: - HADInterstitialAdDelegate
extension MainViewController: HADInterstitialAdDelegate {
    func hadInterstitialAdDidLoad(interstitialAd: HADInterstitialAd) {
        preloaderView.isHidden = true
        self.interstitialAd?.showAdFromRootViewController(self)
    }
    
    func hadInterstitialAdDidClick(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialDidClick")
    }
    
    func hadInterstitialAdDidClose(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialAdDidClose")
    }
    
    func hadInterstitialAdWillClose(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialWillClose")
    }
    
    func hadInterstitialAdDidFail(interstitialAd: HADInterstitialAd, withError error: NSError?) {
        preloaderView.isHidden = true
        print("hadInterstitialDidFail: \(error)")
    }
}

// MARK: - HADVideoInterstitialAdDelegate
extension MainViewController: HADVideoInterstitialAdDelegate {
    func hadVideoInterstitialAdDidLoad(ad: HADVideoInterstitialAd) {
        preloaderView.isHidden = true
        self.videoInterstitialAd?.showAdFromRootViewController(self)
    }
    
    func hadVideoInterstitialAdDidClick(ad: HADVideoInterstitialAd) {
        print("hadVideoInterstitialDidClick")
    }
    
    func hadVideoInterstitialAdDidClose(ad: HADVideoInterstitialAd) {
        print("hadVideoInterstitialAdDidClose")
    }
    
    func hadVideoInterstitialAdWillClose(ad: HADVideoInterstitialAd) {
        print("hadVideoInterstitialWillClose")
    }
    
    func hadVideoInterstitialAdDidFail(ad: HADVideoInterstitialAd, withError error: NSError?) {
        preloaderView.isHidden = true
        print("hadVideoInterstitialDidFail: \(error)")
    }
}



