//
//  UserProfileViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/1/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,IGLDropDownMenuDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dropDownMenu = IGLDropDownMenu()
    var dropDownMenuTwo = IGLDropDownMenu()
    var presentItems = getData()
    
    var itemData:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    
    var dataImage:NSArray = [
        ]
    var dataTitle:[String] = [
        "Watching",
        "Selling",
        "Bought",
        "Sold",
        "My Network"]
    
    
    override func viewDidLayoutSubviews()
    {
        
        setupInit()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell") as! ListTableViewCell
        
        let ran = Int(arc4random_uniform(3))
        
        cell.listHeadingTitle.text = itemData[indexPath.row].title
        cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
        cell.userTypeIcon.image = UIImage(named: itemType[ran])
        cell.listPrice.text = "$\(itemData[indexPath.row].price)"
        cell.usersName.text = "Jonathan"
        cell.listShares.text = "\(itemData[indexPath.row].shares) Shares"
        cell.listComments.text = "\(itemData[indexPath.row].comments) Comments"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.count
    }
   
    
    // func thata fires with tappig on profile image
        func setupInit() {
        
        let dropdownItems:NSMutableArray = NSMutableArray()
        
        for i in 0...(dataTitle.count-1) {
            
            let item = IGLDropDownItem()
            //item.iconImage = UIImage(named: "\(dataImage[i])")
            item.iconImage = nil
            item.text = "\(dataTitle[i])"
            dropdownItems.addObject(item)
        }
        
        dropDownMenu.menuText = "Menu"
        dropDownMenu.backgroundColor = UIColor.clearColor()
        dropDownMenu.tintColor = UIColor.clearColor()
        dropDownMenu.dropDownItems = dropdownItems as [AnyObject]
        dropDownMenu.paddingLeft = 2
        dropDownMenu.frame = CGRectMake(0, 247, self.view.frame.width, 45)
        dropDownMenu.delegate = self
        dropDownMenu.type = IGLDropDownMenuType.Normal
        dropDownMenu.gutterY = 13
        dropDownMenu.itemAnimationDelay = 0.1
        //dropDownMenu.rotate = IGLDropDownMenuRotate.Random //add rotate value for tilting the
        dropDownMenu.reloadView()
        
        
        self.view.addSubview(self.dropDownMenu)
        
    }
    
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        
        let item:IGLDropDownItem = dropDownMenu.dropDownItems[index] as! IGLDropDownItem
        
        
    }
    

    
}

