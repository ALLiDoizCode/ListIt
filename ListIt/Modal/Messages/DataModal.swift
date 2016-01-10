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
    var image:UIImage!
    var isImage:Bool!
    
    init(theText:String,theSender:String,theAttachment:String,theDate:NSDate,theImage:UIImage,hasImage:Bool){
        
        text = theText
        senderId = theSender
        attachment = theAttachment
        date = theDate
        image = theImage
        isImage = hasImage
    }
}

