//
//  Pay.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Venmo_iOS_SDK


class Pay {
    
    // asked permision and sets the app to use the venmo API
    func requestPermissions(recipient:String,amount:Int,note:String){
        
        //Using the Venmo API
        Venmo.sharedInstance().defaultTransactionMethod = .API
        
        let paramPermissions = ["make_payments","access_payment_history","access_feed","access_profile","access_email","access_phone","access_balance","access_friends"]
        
        //Request permissions
        Venmo.sharedInstance().requestPermissions(paramPermissions) { (success, error) -> Void in
            
            if success {
                
                //permision granted
                self.sendPayment(recipient,amount:amount,note:note)
                
            }else{
                
                //premission denied
                
            }
        }
    }
    
    func sendPayment(recipient:String,amount:Int,note:String){
        
        //send request to make payment
        Venmo.sharedInstance().sendPaymentTo(recipient, amount: UInt(amount), note: note) { (transaction, success, error) -> Void in
            
            if success {
                
                print("transaction succeeded!")
                
            }else{
                
                 print("transaction failed \(error.localizedDescription)")
            }
        }
    }
}
