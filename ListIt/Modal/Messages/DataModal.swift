//
//  DataModal.swift
//  ListIt
//
//  Created by Jonathan Green on 1/7/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class MessageModal {
    
    var text = ""
    var senderId = ""
    var attachment = ""
    var date:NSDate!
    
    init(theText:String,theSender:String,theAttachment:String,theDate:NSDate){
        
        text = theText
        senderId = theSender
        attachment = theAttachment
        date = theDate
    }
}

