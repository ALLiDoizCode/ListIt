//
//  ItemsParse.swift
//  ListIt
//
//  Created by Jonathan Green on 12/11/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import SwiftEventBus



class getItems {
    
    let newItem = PFObject(className:"Items")
    
    let query = PFQuery(className: "Items")
    
    var items:[item] = []
    
    func addItem(icon:UIImage,icon2:UIImage,icon3:UIImage,userIcon:String,title:String,price:Float,shares:String,comments:String,desc:String,type:String,category:String) {
        
        
        let iconData = UIImageJPEGRepresentation(icon, 0.5)
        let iconFile = PFFile(name:"image.png", data:iconData!)
        
        let iconData2 = UIImageJPEGRepresentation(icon2, 0.5)
        let iconFile2 = PFFile(name:"image.png", data:iconData2!)
        
        let iconData3 = UIImageJPEGRepresentation(icon3, 0.5)
        let iconFile3 = PFFile(name:"image.png", data:iconData3!)
        
        newItem["Icon"] = iconFile
        newItem["Icon2"] = iconFile2
        newItem["Icon3"] = iconFile3
        newItem["UserIcon"] = userIcon
        newItem["Title"] = title
        newItem["Price"] = price
        newItem["Shares"] = shares
        newItem["Comments"] = comments
        newItem["Description"] = desc
        newItem["Category"] = category
        newItem["Type"] = type
        
        newItem.saveEventually { (result, error) -> Void in
            
            if error == nil {
                
                print("item saved")
            }else {
                
                print("error: \(error?.description)")
            }
        }
        
    }
    
    func itemsList(){
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let theIcon = object.objectForKey("Icon") as! PFFile!
                        let theUserIcon = object.objectForKey("UserIcon") as! PFFile!
                        let theTitle = object.objectForKey("Title") as! String!
                        let theShares = object.objectForKey("Shares") as! String!
                        let theComments = object.objectForKey("Comments") as! String!
                        let thePrice = object.objectForKey("Price") as! Int!
                        
                        let theItem:item = item(theIcon: theIcon.url!, theUserIcon: theUserIcon.url!, theTitle: theTitle, theShares: theShares, theComments: theComments, thePrice: thePrice)
                        
                        self.items.append(theItem)
                    }
                    
                    SwiftEventBus.postToMainThread("Items", sender: self.items)
                }
            }
        }
    }
}