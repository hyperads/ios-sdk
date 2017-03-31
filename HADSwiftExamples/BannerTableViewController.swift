//
//  TableViewController.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

class BannerCell: UITableViewCell, HADBannerAdDelegate {
    
    func hadBannerAdDidLoad(bannerAd: HADBannerAd) {
        print("hadViewDidLoad")
    }
    
    func hadBannerAdDidClick(bannerAd: HADBannerAd) {
        print("hadViewDidClick")
    }
    
    func hadBannerAdDidFail(bannerAd: HADBannerAd, withError error: NSError?) {
        print("hadViewDidFail: \(String(describing: error?.localizedDescription))")
    }
}

class BannerTableViewController: UITableViewController {
    
    var alreadyLoadedAdsInRows: [Int] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 20 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AD", for: indexPath) as! BannerCell
            if !alreadyLoadedAdsInRows.contains(indexPath.row) {
                alreadyLoadedAdsInRows.append(indexPath.row)
                
                let bannerView = HADBannerAd(placementID: "KoMrp58X", bannerSize:.banner320x50, viewController: self)
                bannerView.delegate = cell
                bannerView.loadAd()
                cell.contentView.addSubview(bannerView)
                
                //set ad size
                bannerView.frame = CGRect(x:0, y:0, width:cell.frame.width, height:HADBannerAdSize.getSize(.banner320x50).height)
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 20 == 0 ? 50 : 44
    }
}
