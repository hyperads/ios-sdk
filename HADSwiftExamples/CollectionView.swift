//
//  CollectionView.swift
//  HADExamples
//
//  Created by Mihael Isaev on 30.09.16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import Foundation
import HADFramework

class ADCollectionCell: UICollectionViewCell, HADBannerViewDelegate {
    @IBOutlet weak var bannerView: HADBannerView!
    
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

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var alreadyLoadedAdsInRows: [Int] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 20 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AD", for: indexPath) as! ADCollectionCell
            if !alreadyLoadedAdsInRows.contains(indexPath.row) {
                alreadyLoadedAdsInRows.append(indexPath.row)
                cell.bannerView.loadAd(placementId: "5b3QbMRQ", bannerSize: .height50, delegate: cell)
            }
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 20 == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width*0.25, height: UIScreen.main.bounds.size.width*0.25)
        }
    }
}

