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
import ParseFacebookUtilsV4



class getItems {
    
    let newItem = PFObject(className:"Items")
    
    let query = PFQuery(className: "Items")
    
    let user = PFUser.currentUser()
    
    var items:[item] = []
    var messageList:[item] = []
    var messageItem:[MessageModal] = []
    
    
    func signUp(firstName:String,LastName:String,email:String,passWord:String){
        
        let user = PFUser()
        user.username = email
        user.password = passWord
        user.email = email
        // other fields can be set just like with PFObject
        user["Phone"] = "415-392-0202"
        user["FirstName"] = firstName
        user["LastName"] = LastName
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                
                print(errorString)
                
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                
                SwiftEventBus.postToMainThread("SignedUp")
            }
        }
    }
    
    func login(userName:String,passWord:String){
        
        PFUser.logInWithUsernameInBackground(userName, password: passWord) { (theUser, error) -> Void in
            
            SwiftEventBus.postToMainThread("SignedIn")
        }
        
    }
    
    func signUpFaceBook(){
        
        let manger = PFFacebookUtils.facebookLoginManager()
        manger.loginBehavior = .Web
        
        PFFacebookUtils.logInInBackgroundWithPublishPermissions(["publish_actions"], block: {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("facebook boom")
                // Your app now has publishing permissions for the user
                 SwiftEventBus.postToMainThread("SignedIn")
            }
        })
    }
    
    func addListOfMessages(sellerId:String){
        
        let name = (user?.objectId)! + sellerId
        
       user?.addObject("Convo\(name)", forKey: "Messages")
        
        user?.saveInBackground()

    }
    
    func getListOfgMessages(){
        
       let list = user?.objectForKey("Messages") as! [String]
        
        for messageItem in list {
            
            let messageQuery = PFQuery(className: messageItem)
            
            messageQuery.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            let theIcon = object.objectForKey("Icon") as! PFFile!
                            let theDescription = object.objectForKey("Description") as! String!
                            let theTitle = object.objectForKey("Title") as! String!
                            let objectId = object.objectId

                            let theItem:item = item(theIcon: theIcon.url!, theUserIcon: "", theTitle: theTitle, theShares: "", theComments: "", thePrice: 0, theDescription:theDescription,theObjectId:objectId,theTime:"")
                            
                            self.messageList.append(theItem)
                        }
                        
                        SwiftEventBus.postToMainThread("MessageList", sender: self.messageList)
                    }
                }
            }
        }
      
    }

    
    func sendMessage(message:MessageModal,sellerId:String,theTitle:String,theDescription:String,theImage:UIImage){
        
        let name = (user?.objectId)! + sellerId
        
       
        let converstation = PFObject(className:"Convo\(name)")
        
        if message.isImage == true {
            
            let photoData = UIImageJPEGRepresentation(message.image, 0.2)
            let photoFile = PFFile(name:"photo", data:photoData!)
            let iconData = UIImageJPEGRepresentation(theImage, 0.2)
            let iconFile = PFFile(name:"photo", data:iconData!)
            
            converstation["UserId"] = message.senderId
            converstation["Image"] = photoFile
            converstation["Title"] = theTitle
            converstation["Description"] = theDescription
            converstation["Icon"] = iconFile
            
        }else {
            
            let iconData = UIImageJPEGRepresentation(theImage, 0.2)
            let iconFile = PFFile(name:"photo", data:iconData!)
            
            converstation["UserId"] = message.senderId
            converstation["Message"] = message.text
            converstation["Title"] = theTitle
            converstation["Description"] = theDescription
            converstation["Icon"] = iconFile
            
        }
        
        converstation.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                SwiftEventBus.postToMainThread("MessageSent")
                print("client fired")
            }else{
                
                print(error)
            }
        }
        
        
    }
    
    
    func getMessages(sellerId:String){
        
        self.messageItem = []
        
        let name = (user?.objectId)! + sellerId
        
        let queryMessage = PFQuery(className: "Convo\(name)")
        
        queryMessage.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        if  let image = object.objectForKey("Image") as! PFFile! {
                            
                            let messageId = object.objectForKey("UserId") as! String!
                            let time = object.createdAt
                            
                            print("the image url \(image.url)")
                            
                            let theMesssage = MessageModal(theText: "", theSender: messageId, theAttachment: image.url!,theDate:time!,theImage:UIImage(named: "placeholder")!,hasImage:true)
                            
                            self.messageItem.append(theMesssage)
                        }else if let message = object.objectForKey("Message") as! String! {
            
                            let messageId = object.objectForKey("UserId") as! String!
                            let time = object.createdAt
                            
                            print(time)
                            
                            let theMesssage = MessageModal(theText: message, theSender: messageId, theAttachment: "",theDate:time!,theImage:UIImage(named: "placeholder")!,hasImage:false)
                            
                            self.messageItem.append(theMesssage)
                        }

                    }
                    
                    SwiftEventBus.postToMainThread("message", sender: self.messageItem)
                }
            }
        }
    }
    
    func addItem(icon:UIImage,icon2:UIImage,icon3:UIImage,userIcon:UIImage,title:String,price:Float,shares:String,comments:String,desc:String,type:String,category:String) {
        
        let userIconData = UIImageJPEGRepresentation(userIcon, 0.5)
        let userIconFile = PFFile(name:"image.png", data:userIconData!)
        
        let iconData = UIImageJPEGRepresentation(icon, 0.5)
        let iconFile = PFFile(name:"image.png", data:iconData!)
        
        let iconData2 = UIImageJPEGRepresentation(icon2, 0.5)
        let iconFile2 = PFFile(name:"image.png", data:iconData2!)
        
        let iconData3 = UIImageJPEGRepresentation(icon3, 0.5)
        let iconFile3 = PFFile(name:"image.png", data:iconData3!)
        
        newItem["Icon"] = iconFile
        newItem["Icon2"] = iconFile2
        newItem["Icon3"] = iconFile3
        newItem["UserIcon"] = userIconFile
        newItem["Title"] = title
        newItem["Price"] = price
        newItem["Shares"] = shares
        newItem["Comments"] = comments
        newItem["Description"] = desc
        newItem["Category"] = category
        newItem["Type"] = type
        
        newItem.saveInBackgroundWithBlock { (status, error) -> Void in
            
            if error == nil {
                print("item saved")
                
                SwiftEventBus.postToMainThread("ItemSaved")
                
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
                        let theDescription = object.objectForKey("Description") as! String
                        let objectId = object.objectId
                        let time = object.createdAt
                        
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
                        dateFormatter.timeStyle = .ShortStyle
                        let date = dateFormatter.stringFromDate(time! as NSDate)
                        print(date)
                        
                        let theItem:item = item(theIcon: theIcon.url!, theUserIcon: theUserIcon.url!, theTitle: theTitle, theShares: theShares, theComments: theComments, thePrice: thePrice, theDescription:theDescription,theObjectId:objectId,theTime:date)
                        
                        self.items.append(theItem)
                    }
                    
                    SwiftEventBus.postToMainThread("Items", sender: self.items)
                }
            }
        }
    }
}