//
//  CollectionView.swift
//  HADFramework
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import Foundation
import HADFramework

class NativeCollectionCell : UICollectionViewCell {
    
    var textLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.size.width, height:frame.size.height))
        textLabel.textColor = .white
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        self.textLabel = textLabel
        contentView.backgroundColor = .cyan
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}

extension NativeCollectionViewController: HADNativeAdDelegate {
    func nativeAdWillLogImpression(nativeAd: HADNativeAd) {
        print("nativeAdWillLogImpression")
    }
    
    func hadNativeAdDidClick(nativeAd: HADNativeAd) {
        print("hadNativeAdDidClick")
    }
    
    //func nativeAdDidFinishHandlingClick(nativeAd: HADNativeAd) {
    //    print("nativeAdDidFinishHandlingClick")
    //}
}

//MARK: - HADNativeAdsManagerDelegate implementation

extension NativeCollectionViewController: HADNativeAdsManagerDelegate {
    func nativeAdsLoaded() {
        print("HADNativeAdsManagerDelegate nativeAdsLoaded")
        
        guard let manager = self.adsManager else {
            print("Error")
            return
        }
        self.adsManager?.delegate = nil
        self.adsManager = nil
        
        let cellProvider = HADNativeAdCollectionViewCellProvider(manager: manager, forType: .height300)
        ads = cellProvider
        ads?.delegate = self
        
        collectionView?.reloadData()
        collectionView?.layoutIfNeeded()
    }
    
    func nativeAdsFailedToLoad(error: NSError?) {
        print("HADNativeAdsManagerDelegate nativeAdsFailedToLoad")
    }
}


class NativeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var adsManager:HADNativeAdsManager?
    var ads:HADNativeAdCollectionViewCellProvider?
    var _collectionViewContentArray:[String]?
    var adCellsCreated:Bool = false
    
    let stride = 37
    
    var alreadyLoadedAdsInRows = [Int]()
    var alreadyLoadedAds = [Int: HADNativeAd]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(NativeCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        self.loadNativeAds()
        
        print("\(self.collectionView?.frame)")
        print("\(self.collectionView?.contentSize)")
    }
    
    func collectionViewContentArray() -> [String]?
    {
        if self._collectionViewContentArray == nil {
            self._collectionViewContentArray = [String]()
            
            for i in 0...120 {
                self._collectionViewContentArray?.append("Cell \(i)")
            }
        }
        
        return self._collectionViewContentArray
    }
    
    func loadNativeAds() {
        if adsManager == nil {
            adsManager = HADNativeAdsManager(placementID: "W03qNzM6", numAdsRequested: 5)
            adsManager?.delegate = self
            //adsManager?.mediaCachePolicy = .all
            adsManager?.loadAds()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = collectionViewContentArray()?.count
        if let newCount = ads?.adjustCount(count:count!, forStride:stride) {
            return newCount
        }
        
        return count!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
        if ads?.isAdCell(indexPath:indexPath, forStride:stride) == true, let cell = ads?.cellOf(collectionView, forRowAt: indexPath) {
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NativeCollectionCell
            var label = "---"
            // In this example we need to adjust the index back to the domain of the data.
            if let newIndexPath = ads?.adjustNonAdCell(indexPath:indexPath, forStride:stride) {
                label = (collectionViewContentArray()?[newIndexPath.row])!
            }
            cell.textLabel?.text = label
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if ads?.isAdCell(indexPath:indexPath, forStride:stride) == true {
            return (ads?.sizeOf(collectionView, forRowAt: indexPath))!
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width*0.25, height: UIScreen.main.bounds.size.width*0.25)
        }
    }
}
