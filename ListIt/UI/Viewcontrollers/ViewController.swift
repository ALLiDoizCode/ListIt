//
//  ViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let venmo:PresentVenmo = PresentVenmo()
    let user:User = User()
    let parseData:getData = getData()
    
    var itemData:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
   
    @IBOutlet weak var tableView: UITableView!
 
    
    
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
        self.parseData.getItem { (items) -> Void in
            
            self.itemData = items
            
            
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(items[0].icon)")
            print("UserIcon: \(items[0].userIcon)")
            print("Title: \(items[0].title)")
            print("Price: \(items[0].price)")
            print("Shares: \(items[0].shares)")
            print("Comments: \(items[0].comments)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableView.reloadData()
                
                });
            
           
        }
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return itemData.count
    }
    
 
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:ListTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListTableViewCell
        
         let ran = Int(arc4random_uniform(3))
        
        cell.listHeadingTitle.text = itemData[indexPath.row].title
        cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!)
        cell.userImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].userIcon)!)
        cell.userTypeIcon.image = UIImage(named: itemType[ran])
        cell.listPrice.text = "$\(itemData[indexPath.row].price)"
        cell.usersName.text = "Jonathan"
        cell.listShares.text = "\(itemData[indexPath.row].shares) Shares"
        cell.listComments.text = "\(itemData[indexPath.row].comments) Comments"
        
       
        
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
        
        let controller:DetailViewController = segue.destinationViewController as! DetailViewController
        
        let index = tableView.indexPathForSelectedRow
        
        dispatch_async(dispatch_get_main_queue(), {
            
            controller.itemImage.kf_setImageWithURL(NSURL(string:self.itemData[index!.row].icon)!)
            controller.itemTitle.text = self.itemData[index!.row].title
            controller.price.text = "$\(self.itemData[index!.row].price)"
            controller.name.text = "Jonathan"
            //controller.theDescription.text = theItem.description
            controller.shares.text = "\(self.itemData[index!.row].shares) Shares"
            controller.comments.text = "\(self.itemData[index!.row].comments) Comments"
            
        });
        
    
    }


}

