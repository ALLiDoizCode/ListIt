//
//  ParsePresenters.swift
//  ListIt
//
//  Created by Jonathan Green on 12/11/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus
import JSQMessagesViewController
import Kingfisher
import ImageLoader


class getData {

    
    var grabItems:getItems = getItems()
    
    var channel:channels = channels()
    
    var jsqMessages : [JSQMessage] = []
    var jsqMessageImage : [JSQMessage] = []
    var theImage:UIImage = UIImage()
    let imageView = UIImageView()
    
    func getItem(completionHandler: (([item]!) -> Void)?){
        
        SwiftEventBus.onBackgroundThread(self, name: "Items") { (result) -> Void in
            
            let items = result.object as! [item]
            
            completionHandler!(items)
            
        }
        
        grabItems.itemsList()
    }
    
    func addItem(icon:UIImage,icon2:UIImage,icon3:UIImage,userIcon:UIImage,title:String,price:Float,shares:String,comments:String,desc:String,type:String,category:String) {
        
        grabItems.addItem(icon, icon2: icon2, icon3: icon3, userIcon: userIcon, title: title, price: price, shares: shares, comments: comments,desc: desc,type:type,category:category)
        
    }
    
    /*func getMessage(completionHandler: (([MessageModal]!) -> Void)?)  -> JSQMessage {
        
        let jsqMessage = JSQMessage(senderId: message.senderId, senderDisplayName: message.senderId, date: message.created_at, text: message.text)
        return jsqMessage
    }*/
    
    func getMessages(sellerId:String,completionHandler: (([JSQMessage]!,[JSQMessage]!,[MessageModal]!) -> Void)?){
        
        SwiftEventBus.onBackgroundThread(self, name: "message") { (result) -> Void in
            
            let group = dispatch_group_create()
            
            let items = result.object as! [MessageModal]
            
            var imageMessage:JSQMessage!
            
             self.jsqMessages = []
            self.jsqMessageImage = []
            
            for message in items {
                
                dispatch_group_enter(group)
                
                
                
                self.imageView.kf_setImageWithURL(NSURL(string: message.attachment)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: .None, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    
                    if message.isImage == true && error == nil {
                        
                        print("attachment \(image)")
                        
                        self.theImage = image!
                        
                    }
                    
                    dispatch_group_leave(group)
                    
                    let jsqMessage = JSQMessage(senderId: message.senderId, senderDisplayName: message.senderId, date: message.date, text: message.text)
                    
                    self.jsqMessages.append(jsqMessage)
                    
                    
                    let photo = JSQPhotoMediaItem(image:self.theImage)
                    
                    
                    imageMessage = JSQMessage(senderId: message.senderId, displayName:  message.senderId, media: photo)
                    
                    self.jsqMessageImage.append(imageMessage)
                    
                    print(imageMessage.media)
                    
                    
                })
                
            }
            
            
            
            dispatch_group_notify(group, dispatch_get_main_queue(), { () -> Void in
                
                SwiftEventBus.unregister(self, name: "message")
                
                 completionHandler!(self.jsqMessageImage,self.jsqMessages,items)
            })
        }
        
        grabItems.getMessages(sellerId)
        
    }
   
    func sendMessage(message:JSQMessage,sellerId:String,hasImage:Bool,image:UIImage,completionHandler: (() -> Void)?) {
        
        if hasImage == true {
            
            let messageToSend = MessageModal(theText: "", theSender: message.senderId, theAttachment: "",theDate:NSDate(),theImage:image,hasImage:hasImage)
            
            grabItems.sendMessage(messageToSend,sellerId: sellerId)
            
            completionHandler!()
            
            print("presenter fired")
        }else {
            
            let messageToSend = MessageModal(theText: message.text, theSender: message.senderId, theAttachment: "",theDate:NSDate(),theImage:UIImage(named: "placeholder")!,hasImage:hasImage)
            
            grabItems.sendMessage(messageToSend,sellerId: sellerId)
            
            completionHandler!()
            
            print("presenter fired")
        }
        
    }
    
    func addChannel(sellerId: String) {
        
        channel.messageChannel(sellerId)
    }
}



