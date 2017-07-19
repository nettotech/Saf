//
//  TransacoesViewControler.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 23/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import UIKit

class TransacoesViewController: UITableViewController {
    
    var coreDataSaf: CoreDataSaf!
    var transactions: [Transactions] = []
    var detalheAccount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.coreDataSaf = CoreDataSaf()
        
        self.transactions = self.coreDataSaf.retrieveTransactionsAccount(accountID: detalheAccount)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction: Transactions
        transaction = self.transactions[ indexPath.row ]
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! TransacaoCelula
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMM"
        
        celula.dataLabel.text = dateFormatter.string(from: transaction.date! as Date)
        celula.descricaoLabel.text = transaction.transaction_description
        celula.valorLabel.text = formatCurrency(value: Double( transaction.ammount! ))
        celula.comentarioLabel.text = transaction.comments
        celula.saldoLabel.text = formatCurrency(value: Double( transaction.ammount! ))
        
        return celula
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheTransacao" {
        
            if let indexPath = tableView.indexPathForSelectedRow {
            
                let transacaoSelecionada = self.transactions[ indexPath.row ]
                let viewControleDestino = segue.destination as! DetalheViewController
                viewControleDestino.detalheTransacao = transacaoSelecionada
  
            }
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
