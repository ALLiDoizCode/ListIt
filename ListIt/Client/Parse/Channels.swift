//
//  Channels.swift
//  ListIt
//
//  Created by Jonathan Green on 1/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class channels {
    
    let user = PFUser.currentUser()
    
    func messageChannel(sellerId:String) {
        
        let channel = (user?.objectId)! + sellerId
    
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject("Convo\(channel)", forKey: "channels")
        currentInstallation.saveInBackground()
    }
}