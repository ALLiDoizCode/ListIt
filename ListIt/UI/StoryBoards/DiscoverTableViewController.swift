//
//  DiscoverTableViewController.swift
//  ListIt
//
//  Created by Chris Collins on 12/11/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController, UISearchResultsUpdating {

    let listProductsArray = []
    var filteredProductArray = [String]()
    var resultSearchController = UISearchController();
    
    @IBAction func changeListViewType(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active {
            //return filtered search array if active
            return self.filteredProductArray.count
        }
        //return whole array if not active
            return  self.listProductsArray.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell?

        if self.resultSearchController.active {
            cell!..textLabel?.text = self.filteredProductArray[indexPath.row]
        }
        else
        {
            cell!.textLabel?.text = self.listProductsArray[indexPath.row]
        }
        

        return cell
    }
   
    //
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //remove items in the filtered array
        self.filteredProductArray.removeAll(keepCapacity: false)
        //searching for items and find text to return into array
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.listProductsArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredProductArray = array as! [String]
        //reload with filtered data
        self.tableView.reloadData()
    }

}
