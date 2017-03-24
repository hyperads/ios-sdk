//
//  TableViewController.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

class BannerCell: UITableViewCell, HADAdViewDelegate {
    
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
                
                let bannerView = HADAdView(placementID: "W03qNzM6", adSize:.height50Banner, viewController: self)
                bannerView.loadAd()
                bannerView.delegate = cell
                cell.contentView.addSubview(bannerView)
                
                let height = HADAdSize.getSize(.height50Banner).height
                //set ad size
                bannerView.frame = CGRect(x:0, y:0, width:cell.contentView.frame.width, height:height);
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
