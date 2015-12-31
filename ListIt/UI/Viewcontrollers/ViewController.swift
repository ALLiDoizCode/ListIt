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



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var grabItems:getItems = getItems()
    
    var itemData:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 75, 20))
    let tapRect = UITapGestureRecognizer()
   
    @IBOutlet weak var tableView: UITableView!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creates tap gesture and adds it to the scene
        tapRect.addTarget(self, action: "tappedView:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1

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
    
    
     func tappedView(sender:UITapGestureRecognizer) {
     
        self.performSegueWithIdentifier("Profile", sender: self)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return itemData.count
    }
    
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:ListTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListTableViewCell
        
         let ran = Int(arc4random_uniform(3))
        cell.listHeadingTitle.text = itemData[indexPath.row].title
        cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
        cell.userImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"))
        cell.userTypeIcon.image = UIImage(named: itemType[ran])
        cell.listPrice.text = "$\(itemData[indexPath.row].price)"
        cell.usersName.text = "Jonathan"
        cell.listShares.text = "\(itemData[indexPath.row].shares) Shares"
        cell.listComments.text = "\(itemData[indexPath.row].comments) Comments"
        
        cell.userImage.addGestureRecognizer(tapRect)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            cell.userImage.layer.cornerRadius = cell.userImage.layer.frame.width/2
            cell.userImage.layer.masksToBounds = true
            
        });

        
        return cell
    
        
    }
    
    
    func setupSearchBar(){
        
        searchBar.placeholder = "Type Here"
        self.navigationItem.titleView = searchBar
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Grid" {
            
             let controller:GridViewController = segue.destinationViewController as! GridViewController
            
                controller.items = self.itemData
            
        }
        
        if segue.identifier == "Detail" {
            
                let indexPaths = self.tableView.indexPathForSelectedRow
                
                let controller:DetailViewController = segue.destinationViewController as! DetailViewController
                controller.theImage = self.itemData[(indexPaths?.row)!].icon
                controller.theTitle = self.itemData[(indexPaths?.row)!].title
                controller.thePrice = "$\(self.itemData[(indexPaths?.row)!].price)"
                controller.theName = "Jonathan"
                //controller.itemDescription.text = theItem.description
                controller.theShares = "\(self.itemData[(indexPaths?.row)!].shares) Shares"
                controller.theComments = "\(self.itemData[(indexPaths?.row)!].comments) Comments"
         
            
        }
        
    }


}

