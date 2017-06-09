//
//  Transacao.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 23/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import Foundation
import UIKit

class Transacao: NSObject {
    
    var data: String!
    var descricao: String!
    var comentario: String!
    var valor: Float!
    var saldo: Float!
    
    init(data:String, descricao: String, comentario: String, valor:Float, saldo:Float){
        self.data = data
        self.descricao = descricao
        self.comentario = comentario
        self.valor = valor
        self.saldo = saldo

    }
    
    
}
