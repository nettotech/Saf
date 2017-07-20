//
//  DetalheViewController.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 27/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var descricaoTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var comentarioTextView: UITextView!
    
    var detalheTransacao: Transactions!
    var coreDataSaf: CoreDataSaf!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.coreDataSaf = CoreDataSaf()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if detalheTransacao != nil {
            dataTextField.text = dateFormatter.string(from: detalheTransacao.date! as Date)
            descricaoTextField.text = detalheTransacao.transaction_description
            valorTextField.text = String(detalheTransacao.ammount)
            comentarioTextView.text = detalheTransacao.comments
        }else{
            //Não existe transacao, anotação nova, vamos inserir
            dataTextField.text = ""
            descricaoTextField.text = ""
            valorTextField.text = "0"
            comentarioTextView.text = ""
        }
  
    }
    
    @IBAction func saveTransaction(_ sender: Any) {

        if detalheTransacao != nil {
            //existe uma transacao, vamos atualizá-la
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            self.coreDataSaf.updateTransaction(transaction: detalheTransacao, accountID: self.detalheTransacao.accountID, ammount: valorTextField.text!, categoryID: self.detalheTransacao.categoryID, comments: comentarioTextView.text!, date: self.dataTextField.text!, transaction_description: descricaoTextField.text!, type: self.detalheTransacao.type)
        }else{
            //transacao nova, vamos salvá-la
            if descricaoTextField.text != "" {
                self.coreDataSaf.addTransaction(ammount: valorTextField.text!, comments: comentarioTextView.text, date: self.dataTextField.text!, transaction_description: descricaoTextField.text!)
            }
        }
        
         // Não está atualizando a data e o valor. Precisa desconverter dos formatos.
        
        //Retorna para a tela inicial
        _ = self.navigationController?.popToRootViewController(animated: true)
        

    }
    
}

