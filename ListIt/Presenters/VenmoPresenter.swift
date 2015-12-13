//
//  VenmoPresenters.swift
//  ListIt
//
//  Created by Jonathan Green on 12/11/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Venmo_iOS_SDK
import SwiftEventBus

class PresentVenmo {
    
    
    let user:User = User()
    var accessToken:String = ""
    
    func getUser(completionHandler: ((String!) -> Void)?){
        
            SwiftEventBus.onBackgroundThread(self, name: "token") { result in
                
                let token = result.object as! String
                
               completionHandler!(token)
                
            }
        
        self.user.login()
        
    }
    
    
}