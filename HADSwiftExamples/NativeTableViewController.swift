//
//  TableViewController.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

extension NativeTableViewController: HADNativeAdDelegate {
    func nativeAdWillLogImpression(nativeAd: HADNativeAd) {
        print("nativeAdWillLogImpression")
    }
    
    func hadNativeAdDidClick(nativeAd: HADNativeAd) {
        print("hadNativeAdDidClick")
    }
}

//MARK: - HADNativeAdsManagerDelegate implementation

extension NativeTableViewController: HADNativeAdsManagerDelegate {
    func nativeAdsLoaded() {
        print("HADNativeAdsManagerDelegate nativeAdsLoaded")
        
        guard let manager = self.adsManager else {
            print("Error, no manager found")
            return
        }
        self.adsManager?.delegate = nil
        self.adsManager = nil
        
        let cellProvider = HADNativeAdTableViewCellProvider(manager: manager, forType: .height300)
        ads = cellProvider
        ads?.delegate = self
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    
    func nativeAdsFailedToLoad(error: NSError?) {
        print("HADNativeAdsManagerDelegate nativeAdsFailedToLoad")
    }
}

class NativeTableViewController: UITableViewController {
    
    var adsManager:HADNativeAdsManager?
    var ads:HADNativeAdTableViewCellProvider?
    var _tableViewContentArray:[String]?
    
    let stride = 15
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.loadNativeAds()
    }
    
    func tableViewContentArray() -> [String]?
    {
        if self._tableViewContentArray == nil {
            self._tableViewContentArray = [String]()
            
            for i in 0...120 {
                self._tableViewContentArray?.append("TableView Cell \(i)")
            }
        }
    
        return self._tableViewContentArray
    }
    
    func loadNativeAds() {
        if adsManager == nil {
            adsManager = HADNativeAdsManager(placementID: "W03qNzM6", numAdsRequested: 5)
            adsManager?.delegate = self
            //adsManager?.mediaCachePolicy = .all
            adsManager?.loadAds()
        }
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = tableViewContentArray()?.count
        if let newCount = ads?.adjustCount(count:count!, forStride:stride) {
            return newCount
        }
        
        return count!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
        if ads?.isAdCell(indexPath:indexPath, forStride:stride) == true {
            return (ads?.cellOf(tableView, forRowAt: indexPath))!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            var label = "---"
            // In this example we need to adjust the index back to the domain of the data.
            if let newIndexPath = ads?.adjustNonAdCell(indexPath:indexPath, forStride:stride) {
                label = (tableViewContentArray()?[newIndexPath.row])!
            }
            cell.textLabel?.text = label
            return cell
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // The ad cell provider knows the height of ad cells based on its configuration
        if ads?.isAdCell(indexPath:indexPath, forStride:stride) == true {
            return (ads?.heightOf(tableView, forRowAt: indexPath))!
        } else {
            return 60
        }
    }
}


