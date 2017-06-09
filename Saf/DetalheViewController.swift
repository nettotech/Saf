//
//  DetalheViewController.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 27/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//
import Foundation
import UIKit

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var descricaoTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var comentarioTextView: UITextView!
    
    var detalheTransacao: Transacao!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        dataTextField.text = detalheTransacao.data
        descricaoTextField.text = detalheTransacao.descricao
        valorTextField.text = formatCurrency(value: Double(detalheTransacao.valor))
        comentarioTextView.text = detalheTransacao.comentario
  
    }
    
    
}

