//
//  AddListingViewController.swift
//  ListIt
//
//  Created by Chris Collins on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController, UIScrollViewDelegate, IGLDropDownMenuDelegate {

    var dropDownMenu = IGLDropDownMenu()
    var dropDownMenuTwo = IGLDropDownMenu()
    
    
    var dataImage:NSArray = [
        "Business_icon_small.png",
        "Individual_Icon.png",
        "Group_Icon.png"]
    var dataTitle:NSArray = [
        "Business",
        "Individual",
        "Community"]
    
    var  categoryImage:NSArray = [
        "Business_icon_small.png",
        "Individual_Icon.png",
        "Group_Icon.png"]
    var categirtTitle:NSArray = [
        "Business",
        "Individual",
        "Community"]
    
    @IBOutlet weak var MainImageView: UIScrollView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
  
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var shortDescription: UITextField!
    @IBOutlet weak var listingType: UILabel!
    @IBOutlet weak var selectCategory: UILabel!
    @IBOutlet weak var listPrice: UITextField!
    
    @IBOutlet weak var shareFacebook: UITextField!
    @IBOutlet weak var shareToggle: UISwitch!
    
    
    @IBAction func listItButton(sender: UIButton) {
    }
    
    
    
    
    override func viewDidLayoutSubviews()
    {
        
        firstImage.layer.cornerRadius = 10
        firstImage.layer.masksToBounds = true
        
        secondImage.layer.cornerRadius = 10
        secondImage.layer.masksToBounds = true
        
        thirdImage.layer.cornerRadius = 10
        thirdImage.layer.masksToBounds = true
        
        shareToggle.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       setupInit()
       setupCategory()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInit() {
        
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
    
    func setupCategory() {
        
        let dropdownItems:NSMutableArray = NSMutableArray()
        
        for i in 0...(dataTitle.count-1) {
            
            let item = IGLDropDownItem()
            item.iconImage = UIImage(named: "\(dataImage[i])")
            item.text = "\(dataTitle[i])"
            dropdownItems.addObject(item)
        }
        
        dropDownMenuTwo.menuText = "Select a category"
        dropDownMenuTwo.dropDownItems = dropdownItems as [AnyObject]
        dropDownMenuTwo.paddingLeft = 2
        dropDownMenuTwo.frame = CGRectMake((self.view.frame.size.width/2) - 150, 336, 300, 25)
        dropDownMenuTwo.delegate = self
        dropDownMenu.type = IGLDropDownMenuType.Normal
        dropDownMenuTwo.gutterY = 13
        dropDownMenuTwo.itemAnimationDelay = 0.1
        //dropDownMenu.rotate = IGLDropDownMenuRotate.Random //add rotate value for tilting the
        dropDownMenuTwo.reloadView()
        
        
        self.view.insertSubview(self.dropDownMenuTwo, belowSubview: self.dropDownMenu)
        
    }
    
    func dropDownMenuTwo(dropDownMenuTwo: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        
        let item:IGLDropDownItem = dropDownMenuTwo.dropDownItems[index] as! IGLDropDownItem
        
        
    }
    
    
    
    

}
