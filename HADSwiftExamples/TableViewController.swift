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
        print("ERROR: %@", error?.localizedDescription)
    }
}

class TableViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 20 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("AD", forIndexPath: indexPath) as! ADCell
            cell.bannerView.loadAd("5b3QbMRQ", bannerSize: .Height50, delegate: cell)
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row % 20 == 0 ? 50 : 44
    }
}