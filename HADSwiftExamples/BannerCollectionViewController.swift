//
//  CollectionView.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

class BannerCollectionCell: UICollectionViewCell, HADAdViewDelegate {
    @IBOutlet weak var bannerContainerView: UIView!
    
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

class BannerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var alreadyLoadedAdsInRows: [Int] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 20 == 0 && indexPath.row != 0 {
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AD", for: indexPath) as! BannerCollectionCell
            
                if !alreadyLoadedAdsInRows.contains(indexPath.row) {
                    alreadyLoadedAdsInRows.append(indexPath.row)
                    
                    let bannerView = HADAdView(placementID: "5b3QbMRQ", adSize:.height50Banner, viewController: self)
                    bannerView.loadAd()
                    bannerView.delegate = cell
                    cell.bannerContainerView.addSubview(bannerView)
                    
                    let height = HADAdSize.getSize(.height50Banner).height
                    //set ad size
                    bannerView.frame = CGRect(x:0, y:0, width:cell.frame.width, height:height);
                }
                return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 20 == 0 && indexPath.row != 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width*0.25, height: UIScreen.main.bounds.size.width*0.25)
        }
    }
}
