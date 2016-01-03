//
//  UserProfileViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/1/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
/*
    var dropDownMenu = IGLDropDownMenu()
    var dropDownMenuTwo = IGLDropDownMenu()
    
    
    var dataImage:NSArray = [
        ]
    var dataTitle:[String] = [
        "Watching",
        "Selling",
        "Bought",
        "Sold",
        "My Network"]
    */
    
    override func viewDidLayoutSubviews()
    {
        
        //setupInit()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    
    // func thata fires with tappig on profile image
     /*   func setupInit() {
        
        let dropdownItems:NSMutableArray = NSMutableArray()
        
        for i in 0...(dataTitle.count-1) {
            
            let item = IGLDropDownItem()
            item.iconImage = UIImage(named: "\(dataImage[i])")
            item.text = "\(dataTitle[i])"
            dropdownItems.addObject(item)
        }
        
        dropDownMenu.menuText = "Select listing type"
        dropDownMenu.dropDownItems = dropdownItems as [AnyObject]
        dropDownMenu.paddingLeft = 2
        dropDownMenu.frame = CGRectMake((self.view.frame.size.width/2) - 150, 298, 300, 25)
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
    */

    
}

