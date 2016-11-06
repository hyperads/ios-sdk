//
//  TableViewController.swift
//  HADFramework
//
//  Created by Mihael Isaev on 27/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import HADFramework

class ADCell: UITableViewCell, HADBannerViewDelegate {
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

class TableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 20 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AD", for: indexPath) as! ADCell
            cell.bannerView.loadAd(placementId: "5b3QbMRQ", bannerSize: .height50, delegate: cell)
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 20 == 0 ? 50 : 44
    }
}
