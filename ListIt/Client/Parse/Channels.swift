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
        let currentInstallation = PFInstallation.currentInstallation()
        //currentInstallation.addUniqueObject("\(user?.objectId)\(sellerId)", forKey: "channels")
        currentInstallation.addUniqueObject("user1\(sellerId)", forKey: "channels")
        currentInstallation.saveInBackground()
    }
}