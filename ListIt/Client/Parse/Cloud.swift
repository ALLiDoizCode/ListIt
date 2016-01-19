//
//  Cloud.swift
//  ListIt
//
//  Created by Jonathan Green on 1/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse


class TheCloud {
    
    let user = PFUser.currentUser()
    
    func pushMessage(sellerId:String) {
        
        let channel:String! = (user?.objectId)! + sellerId
        
        PFCloud.callFunctionInBackground("PushMessage", withParameters: ["channel":"Convo\(channel)"]) {
            (response: AnyObject?, error: NSError?) -> Void in
            
            if error != nil {
                
                print(error)
            }else {
                
                print("cloud code fired")
            }
        }
    }
}