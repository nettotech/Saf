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
    
    var tipo: Int!
    var descricao: String!
    var saldo: Float!
    
    init(tipo:Int, descricao: String, saldo:Float){
        self.tipo = tipo
        self.descricao = descricao
        self.saldo = saldo
    }
    
    
}
