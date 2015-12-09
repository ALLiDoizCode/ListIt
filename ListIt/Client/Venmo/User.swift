//
//  User.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Venmo_iOS_SDK

class User {
    
    //gets the data for teh current logged in user
    func currentUser(){
        
        let user:VENUser = Venmo.sharedInstance().session.user
        
        print(user.username)
    }
    
    // asked permision and sets the app to use the Venmo API
    func login(){
        
        //Using the Venmo API
        Venmo.sharedInstance().defaultTransactionMethod = .API
        
        let paramPermissions = ["make_payments","access_payment_history","access_feed","access_profile","access_email","access_phone","access_balance","access_friends"]
        
        //Request permissions
        Venmo.sharedInstance().requestPermissions(paramPermissions) { (success, error) -> Void in
            
            if success {
                
                
                
            }else{
                
                //premission denied
                
            }
        }
    }
    
    func logOut(){
        
        Venmo.sharedInstance().logout()
    }
}