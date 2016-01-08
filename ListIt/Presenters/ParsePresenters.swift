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

class getData {

    
    var grabItems:getItems = getItems()
    
    var channel:channels = channels()
    
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
    
    func getMessages(sellerId:String,completionHandler: (([JSQMessage]!) -> Void)?){
        
        SwiftEventBus.onBackgroundThread(self, name: "message") { (result) -> Void in
            
            let items = result.object as! [MessageModal]
            
            var jsqMessages : [JSQMessage] = []
            
            for message in items {
                
                let jsqMessage = JSQMessage(senderId: message.senderId, senderDisplayName: message.senderId, date: message.date, text: message.text)
                
                jsqMessages.append(jsqMessage)
            }
            
            completionHandler!(jsqMessages)
            
        }
        
        grabItems.getMessages(sellerId)
        
    }
   
    func sendMessage(message:JSQMessage,sellerId:String,completionHandler: (() -> Void)?) {
        
        let messageToSend = MessageModal(theText: message.text, theSender: message.senderId, theAttachment: "",theDate:NSDate())
        
        grabItems.sendMessage(messageToSend,sellerId: sellerId)
        
        completionHandler!()
        
        print("presenter fired")
    }
    
    func addChannel(sellerId: String) {
        
        channel.messageChannel(sellerId)
    }
}



