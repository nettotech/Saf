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
    
    var detalheTransacao: Transactions!

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        
        dataTextField.text = dateFormatter.string(from: detalheTransacao.date! as Date)
        descricaoTextField.text = detalheTransacao.transaction_description
        valorTextField.text = formatCurrency(value: Double(detalheTransacao.ammount!))
        comentarioTextView.text = detalheTransacao.comments
  
    }
    
    
}

