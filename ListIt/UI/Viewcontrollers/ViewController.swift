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

    var presentItems = getData()
    
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

        
        //parseData fill the aray for the listview items with this
        
        presentItems.getItem { (list) -> Void in
            
            self.itemData = list
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(list[0].icon)")
            print("UserIcon: \(list[0].userIcon)")
            print("Title: \(list[0].title)")
            print("Price: \(list[0].price)")
            print("Shares: \(list[0].shares)")
            print("Comments: \(list[0].comments)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableView.reloadData()
                
            });
        }
    
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
        searchBar.resignFirstResponder()
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
        let tempImageView:UIImageView = UIImageView()
        
        if searchActive {
            
            
            if filtered.count != 0 {
                
                cell.listHeadingTitle.text = filtered[indexPath.row].title
                cell.listImage.kf_setImageWithURL(NSURL(string: filtered[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
                tempImageView.kf_setImageWithURL(NSURL(string: filtered[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    
                    cell.userImage.setBackgroundImage(image, forState: UIControlState.Normal)
                    cell.userImage.imageView!.contentMode = .ScaleAspectFill
                })
                cell.userTypeIcon.image = UIImage(named: itemType[ran])
                cell.listPrice.text = "$\(filtered[indexPath.row].price)"
                cell.usersName.text = "Jonathan"
                cell.share.setTitle("\(filtered[indexPath.row].shares) Shares", forState: .Normal)
                cell.comment.setTitle("\(filtered[indexPath.row].comments) Comments", forState: .Normal)
                
            }else {
                
                cell.listHeadingTitle.text = itemData[indexPath.row].title
                cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
                
                tempImageView.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    
                    cell.userImage.setBackgroundImage(image, forState: UIControlState.Normal)
                    cell.userImage.imageView!.contentMode = .ScaleAspectFill
                })
                
                cell.userTypeIcon.image = UIImage(named: itemType[ran])
                cell.listPrice.text = "$\(itemData[indexPath.row].price)"
                cell.usersName.text = "Jonathan"
                cell.share.setTitle("\(itemData[indexPath.row].shares) Shares", forState: .Normal)
                cell.comment.setTitle("\(itemData[indexPath.row].comments) Comments", forState: .Normal)
            }
            
        }else {
            
            cell.listHeadingTitle.text = itemData[indexPath.row].title
            cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
            
            tempImageView.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                
                cell.userImage.setBackgroundImage(image, forState: UIControlState.Normal)
                cell.userImage.imageView!.contentMode = .ScaleAspectFill
            })
           
            cell.userTypeIcon.image = UIImage(named: itemType[ran])
            cell.listPrice.text = "$\(itemData[indexPath.row].price)"
            cell.usersName.text = "Jonathan"
            cell.share.setTitle("\(itemData[indexPath.row].shares) Shares", forState: .Normal)
            cell.comment.setTitle("\(itemData[indexPath.row].comments) Comments", forState: .Normal)
            
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
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
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
                
                if filtered.count != 0 {
                    
                    let controller:DetailViewController = segue.destinationViewController as! DetailViewController
                    controller.theImage = self.filtered[(indexPaths?.row)!].icon
                    controller.theTitle = self.filtered[(indexPaths?.row)!].title
                    controller.thePrice = "$\(self.filtered[(indexPaths?.row)!].price)"
                    controller.itemDescription = self.filtered[(indexPaths?.row)!].description
                    controller.theName = "Jonathan"
                    //controller.itemDescription.text = theItem.description
                    controller.theShares = "\(self.filtered[(indexPaths?.row)!].shares) Shares"
                    controller.theComments = "\(self.filtered[(indexPaths?.row)!].comments) Comments"
                    controller.itemId = self.filtered[(indexPaths?.row)!].objectId
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
                    controller.itemId = self.itemData[(indexPaths?.row)!].objectId
                }
                
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
                controller.itemId = self.itemData[(indexPaths?.row)!].objectId
            }
                
            
        }
        
    }


}

