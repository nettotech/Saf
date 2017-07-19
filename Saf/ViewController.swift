//
//  ViewController.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 23/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import UIKit

func formatCurrency(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2;
    formatter.locale = Locale(identifier: Locale.current.identifier)
    let result = formatter.string(from: value as NSNumber);
    return result!;
}


class ViewController: UITableViewController {

    var coreDataSaf: CoreDataSaf!
    var accounts: [Accounts] = []

    
    var contaBanco: [Accounts] = []
    var contaCartao: [Accounts] = []
    var contaInvestimento: [Accounts] = []
    
    var positionAccount: [Int16] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // var conta: Accounts

        //recuperar Accounts
        self.coreDataSaf = CoreDataSaf()
        
        self.coreDataSaf.deleteAllData(entity: "Accounts")
        self.coreDataSaf.deleteAllData(entity: "Transactions")
        self.coreDataSaf.addAllAccounts()
        self.coreDataSaf.addAllTransactions()
        self.accounts = self.coreDataSaf.retrieveAllAccounts()
        
        for account in accounts {
            if account.type == 0 {
               contaBanco.append( account )
            }
            if account.type == 1 {
               contaCartao.append( account )
            }
            if account.type == 2 {
                contaInvestimento.append( account )
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0{
            return "Bancos"
        }else if section == 1{
            return "Cartoes"
        }else{
            return "Investimentos"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return contaBanco.count
        }else if section == 1{
            return contaCartao.count
        }else{
            return contaInvestimento.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conta: Accounts

        if indexPath.section == 0 {
           conta = self.contaBanco[ indexPath.row ]
        }else if indexPath.section == 1 {
           conta = self.contaCartao[ indexPath.row ]
        } else {
            conta = self.contaInvestimento[ indexPath.row ]
        }
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! ContaCelula
        

        celula.contaLabel.text = conta.accountName
        celula.saldoLabel.text = formatCurrency(value: Double(conta.balance))
        celula.idLabel.text = String(conta.accountID)
        
        positionAccount.append(conta.accountID)
        
        return celula
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheAccount" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
//                let contaSelecionada = String( self.accounts[ indexPath.row ].accountID )
                let contaSelecionada = String( positionAccount[indexPath.row] )
                let viewControleDestino = segue.destination as! TransacoesViewController
                viewControleDestino.detalheAccount = contaSelecionada

// Solução - Ordenar a query de forma a retornar na ordem das seçoes. ???????????????
                
            }
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

