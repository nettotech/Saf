//
//  Conta.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 23/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import Foundation
import UIKit

class Conta: NSObject {
    
    var accountID: Int!
    var account: String!
    var type: Int!
    var balance: Float!
    
    init(accountID:Int, account: String, type:Int, balance:Float){
        self.accountID = accountID
        self.account = account
        self.type = type
        self.balance = balance
    }
    
    
}
