//
//  AddListingViewController.swift
//  ListIt
//
//  Created by Chris Collins on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import ImagePickerSheetController
import Photos
import SwiftSpinner
import SwiftEventBus
import IQKeyboardManagerSwift

class AddListingViewController: UIViewController, UIScrollViewDelegate, IGLDropDownMenuDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    var dropDownMenu = IGLDropDownMenu()
    var dropDownMenuTwo = IGLDropDownMenu()
    let parseData:getData = getData()
    
    
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
    
    let tapRect = UITapGestureRecognizer()
    let tapRect2 = UITapGestureRecognizer()
    let tapRect3 = UITapGestureRecognizer()
    
    
    @IBAction func listItButton(sender: UIButton) {
        
        SweetAlert().showAlert("Are you sure?", subTitle: "You can't change a listing once its made", style: AlertStyle.Warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes, Post it!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                SweetAlert().showAlert("Listing Cancled", subTitle: "Your Listing has been deleted!", style: AlertStyle.Success)
                
            }
            else {
                
                let profileImage = UIImage(named: "me")
                let placeholder = UIImage(named: "placeholder")
                
                if (self.firstImage.image! != placeholder) && (self.secondImage.image! != placeholder) && (self.thirdImage.image! != placeholder) && (profileImage! != placeholder) && (self.headline.text! != "") || (self.listPrice.text! != "") && (self.shortDescription.text! != "") && (self.dropDownMenu.menuText != "") {
                    
                    print("post Button  Pressed")
                    SwiftEventBus.onMainThread(self, name: "ItemSaved") { (result) -> Void in
                        
                        SwiftSpinner.hide({
                            
                            SweetAlert().showAlert("Sweet!", subTitle: "Your Item is Now Listed", style: AlertStyle.CustomImag(imageFile: "Rounded2x"))
                            
                            self.performSegueWithIdentifier("Success", sender: self)
                        })
                    }
                    
                    SwiftSpinner.show("Uploading Image...")
                    
                    
                    
                    self.parseData.addItem(self.firstImage.image!, icon2: self.secondImage.image!, icon3: self.thirdImage.image!, userIcon: profileImage!, title: self.headline.text!, price: Float(self.listPrice.text!)!, shares: "", comments: "", desc: self.shortDescription.text!, type: self.dropDownMenu.menuText, category: "")
                    
                }else {
                    
                    SweetAlert().showAlert("error", subTitle: "One or more fields is empty", style: AlertStyle.Warning)
                }
                
            }
        }
        
    }
    
    
    
    
    override func viewDidLayoutSubviews()
    {
        
        setupInit()
        setupCategory()
        
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
       
        
        // add tap to profileImage
        tapRect.addTarget(self, action:"addImage:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        firstImage.userInteractionEnabled = true
        firstImage.addGestureRecognizer(tapRect)
        tapRect2.addTarget(self, action:"addImage2:")
        tapRect2.numberOfTapsRequired = 1
        tapRect2.numberOfTouchesRequired = 1
        secondImage.userInteractionEnabled = true
        secondImage.addGestureRecognizer(tapRect2)
        tapRect3.addTarget(self, action:"addImage3:")
        tapRect3.numberOfTapsRequired = 1
        tapRect3.numberOfTouchesRequired = 1
        thirdImage.userInteractionEnabled = true
        thirdImage.addGestureRecognizer(tapRect3)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addImage(sender: UITapGestureRecognizer) {
        
        getImage(firstImage)
    }
    
    func addImage2(sender: UITapGestureRecognizer) {
        
        getImage(secondImage)
    }
    
    func addImage3(sender: UITapGestureRecognizer) {
        
        getImage(thirdImage)
    }
    
    // func thata fires with tappig on profile image
    func getImage(imageView: UIImageView) {
        
        let manager = PHImageManager.defaultManager()
        let initialRequestOptions = PHImageRequestOptions()
        initialRequestOptions.resizeMode = .Fast
        initialRequestOptions.deliveryMode = .HighQualityFormat
        
        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
            let controller = UIImagePickerController()
            controller.delegate = self
            var sourceType = source
            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
                sourceType = .PhotoLibrary
                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
            }
            controller.sourceType = sourceType
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        let controller = ImagePickerSheetController(mediaType: .Image)
        controller.maximumSelection = 1
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use This Image", comment: "Action Title"), handler: { _ in
            presentImagePickerController(.Camera)
            }, secondaryHandler: { action, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                    options:initialRequestOptions) { (finalResult, _) in
                        
                        imageView.image = finalResult
                        print(finalResult)
                }
                
                
        }))
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: { _ in
            print("Cancelled")
        }))
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.modalPresentationStyle = .Popover
            controller.popoverPresentationController?.sourceView = view
            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
