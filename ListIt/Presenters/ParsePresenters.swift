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
    
    /*func getMessage(message: Message)  -> JSQMessage {
        
        //let jsqMessage = JSQMessage(senderId: message.senderId, senderDisplayName: message.senderId, date: message.created_at, text: message.text)
        return jsqMessage
    }
    
    func getMessages(messages: [Message]) -> [JSQMessage] {
        
        var jsqMessages : [JSQMessage] = []
        for message in messages {
            jsqMessages.append(self.getMessage(message))
        }
        return jsqMessages
    }*/
   
    func sendMessage(message: JSQMessage) {
        
        let messageToSend = MessageModal()
        messageToSend.text = message.text
        messageToSend.senderId = message.senderId
        
    }
    
    
}



