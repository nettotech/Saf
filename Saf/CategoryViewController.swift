//
//  CategoryViewController.swift
//  Saf
//
//  Created by Mario on 20/07/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    var coreDataSaf: CoreDataSaf!
    var accounts: [Accounts] = []
    var detailAccount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.coreDataSaf = CoreDataSaf()
        
        self.accounts = self.coreDataSaf.retrieveAllAccounts()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.accounts = self.coreDataSaf.retrieveAllAccounts()
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account: Accounts
        account = self.accounts[ indexPath.row ]
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! AccountCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMM"
        
        celula.labelAccount.text = account.accountName
        
        return celula
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailAccount" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let transacaoSelecionada = self.accounts[ indexPath.row ]
                let viewControleDestino = segue.destination as! DetailAccountViewController
                viewControleDestino.detailAccount = transacaoSelecionada
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let account = self.accounts[ indexPath.row ]
            self.coreDataSaf.deleteAccount(account: account)
            
            //atualiza listagem
            //            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //            self.tableView.reloadData()
            
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
