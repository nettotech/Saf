//
//  DetailCategoryViewController.swift
//  Saf
//
//  Created by Mario on 20/07/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    
    var detailCategory: Accounts!
    var coreDataSaf: CoreDataSaf!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coreDataSaf = CoreDataSaf()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if detailCategory != nil {
            //existe uma conta, vamos editá-la
            nameTextField.text = detailAccount.accountName
            balanceTextField.text = String(detailAccount.balance)
            typeTextField.text = String(detailAccount.type)
            
        }else{
            //Não existe conta, conta nova, vamos inserir
            nameTextField.text = ""
            balanceTextField.text = ""
            typeTextField.text = "0"
        }
        
        
    }
    
    @IBAction func saveAccount(_ sender: Any) {
        
        if detailAccount != nil {
            //existe uma conta, vamos atualizá-la
            self.coreDataSaf.updateAccount(account: detailAccount, accountName: self.nameTextField.text!, type: self.typeTextField.text!, balance: self.balanceTextField.text!)
        }else{
            //conta nova, vamos salvá-la
            if nameTextField.text != "" {
                self.coreDataSaf.addAccount(accountName: self.nameTextField.text!, type: self.typeTextField.text!)
            }
        }
        
        
        //Retorna para a tela inicial
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    
}
