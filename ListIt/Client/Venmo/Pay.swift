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
    
    func makePayment(recipient:String,amount:Int,note:String){
        
        //send request to make payment
        Venmo.sharedInstance().sendPaymentTo(recipient, amount: UInt(amount), note: note) { (transaction, success, error) -> Void in
            
            if success {
                
                print("transaction succeeded!")
                
            }else{
                
                 print("transaction failed \(error.localizedDescription)")
            }
        }
    }
    
    func requestPayment(recipient:String,amount:Int,note:String){
        
        //Using the Venmo API
        Venmo.sharedInstance().defaultTransactionMethod = .API
        
        Venmo.sharedInstance().sendRequestTo(recipient, amount: UInt(amount), note: note) { (transaction, success, error) -> Void in
            
            if success {
                
                print("transaction succeeded!")
                
            }else{
                
                print("transaction failed \(error.localizedDescription)")
            }
            
        }
    }
}
