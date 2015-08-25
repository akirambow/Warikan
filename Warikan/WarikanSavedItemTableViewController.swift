//
//  WarikanSavedItemTableViewController.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/11.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

class WarikanSavedItemTableViewController: UITableViewController {
    
    var cellItems = [WarikanSavedItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(WarikanSavedItemTableViewCell.classForCoder(), forCellReuseIdentifier: "SavedItemCell")
        
        cellItems.insert(WarikanSavedItemModel(aTitle: "DUMMY", aDate: NSDate()), atIndex: 0)
   
        print("[SavedItemTableViewController] ViewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("[SavedItemTableViewController] tableView:numberOfRowsInSection")
        return cellItems.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("[SavedItemTableViewController] title=" + cellItems[indexPath.row].getTitle())
        self.performSegueWithIdentifier("showDetailSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SavedItemCell", forIndexPath: indexPath) as! WarikanSavedItemTableViewCell
        cell.textLabel!.text = cellItems[indexPath.row].getTitle()
        cell.detailTextLabel!.text = cellItems[indexPath.row].getDateString()
        return cell
    }
    
}

