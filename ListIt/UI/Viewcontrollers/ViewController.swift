//
//  ViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftEventBus



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{
    
    var grabItems:getItems = getItems()
    
    var itemData:[item] = []
    var filtered:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    var searchActive : Bool = false
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 75, 20))
   
    @IBOutlet weak var tableView: UITableView!
 
    
    override func viewWillAppear(animated: Bool) {
        
        searchActive = false
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()

        // Do any additional setup after loading the view, typically from a nib.
        
       //populate variables with data and UI binding here
    /*    self.venmo.getUser { (token) -> Void in
            let username = self.user.currentUser().user.username
            let userImage = self.user.currentUser().user.profileImageUrl
            print("The Token: \(token)")
            print("UserName: \(username)")
            print("User Image: \(userImage)")
            
            //reload table or collection view
        }*/

        
        //parseData fill the aray for the listview items with this
        SwiftEventBus.onMainThread(self, name: "Items") { (result) -> Void in
            
            let items = result.object as! [item]
            
            self.itemData = items
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(items[0].icon)")
            print("UserIcon: \(items[0].userIcon)")
            print("Title: \(items[0].title)")
            print("Price: \(items[0].price)")
            print("Shares: \(items[0].shares)")
            print("Comments: \(items[0].comments)")
            
            self.tableView.reloadData()
            
        }
        
        grabItems.itemsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark searcbar Protocols
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        var tempArray:[String] = []
        var tempFilter:[String] = []
        
        for var i = 0; i < itemData.count; i++ {
            
            tempArray.append(itemData[i].title)
            
        }
        
        tempFilter = tempArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(tempFilter.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            
            filtered = []
            
            for var i = 0; i < tempFilter.count; i++ {
                
                for var j = 0; j < itemData.count; j++ {
                    
                    if tempFilter[i] == itemData[j].title {
                        
                        filtered.append(itemData[j])
                    }
                    
                }
            }
        }
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            
            return filtered.count
            
        }else {
            
            return itemData.count
        }
        
    }
    
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:ListTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListTableViewCell
        let ran = Int(arc4random_uniform(3))
        
        if searchActive {
            
            if filtered.count != 0 {
                
                cell.listHeadingTitle.text = filtered[indexPath.row].title
                cell.listImage.kf_setImageWithURL(NSURL(string: filtered[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
                cell.userImage.kf_setImageWithURL(NSURL(string: filtered[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"))
                cell.userTypeIcon.image = UIImage(named: itemType[ran])
                cell.listPrice.text = "$\(filtered[indexPath.row].price)"
                cell.usersName.text = "Jonathan"
                cell.listShares.text = "\(filtered[indexPath.row].shares) Shares"
                cell.listComments.text = "\(filtered[indexPath.row].comments) Comments"
                
            }
            
        }else {
            
            cell.listHeadingTitle.text = itemData[indexPath.row].title
            cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
            cell.userImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"))
            cell.userTypeIcon.image = UIImage(named: itemType[ran])
            cell.listPrice.text = "$\(itemData[indexPath.row].price)"
            cell.usersName.text = "Jonathan"
            cell.listShares.text = "\(itemData[indexPath.row].shares) Shares"
            cell.listComments.text = "\(itemData[indexPath.row].comments) Comments"
            
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            
            cell.userImage.layer.cornerRadius = cell.userImage.layer.frame.width/2
            cell.userImage.layer.masksToBounds = true
            
        });
        
        return cell
    
        
    }
    
    
    func setupSearchBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Type Here"
        self.navigationItem.titleView = searchBar
       
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Grid" {
            
             let controller:GridViewController = segue.destinationViewController as! GridViewController
            
                controller.items = self.itemData
            
        }
        
        if segue.identifier == "Detail" {
            
                let indexPaths = self.tableView.indexPathForSelectedRow
            
            if searchActive {
                
                let controller:DetailViewController = segue.destinationViewController as! DetailViewController
                controller.theImage = self.filtered[(indexPaths?.row)!].icon
                controller.theTitle = self.filtered[(indexPaths?.row)!].title
                controller.thePrice = "$\(self.filtered[(indexPaths?.row)!].price)"
                controller.itemDescription = self.filtered[(indexPaths?.row)!].description
                controller.theName = "Jonathan"
                //controller.itemDescription.text = theItem.description
                controller.theShares = "\(self.filtered[(indexPaths?.row)!].shares) Shares"
                controller.theComments = "\(self.filtered[(indexPaths?.row)!].comments) Comments"
                
            }else {
                
                let controller:DetailViewController = segue.destinationViewController as! DetailViewController
                controller.theImage = self.itemData[(indexPaths?.row)!].icon
                controller.theTitle = self.itemData[(indexPaths?.row)!].title
                controller.thePrice = "$\(self.itemData[(indexPaths?.row)!].price)"
                controller.itemDescription = self.itemData[(indexPaths?.row)!].description
                controller.theName = "Jonathan"
                //controller.itemDescription.text = theItem.description
                controller.theShares = "\(self.itemData[(indexPaths?.row)!].shares) Shares"
                controller.theComments = "\(self.itemData[(indexPaths?.row)!].comments) Comments"
            }
                
            
        }
        
    }


}

