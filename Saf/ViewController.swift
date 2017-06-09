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

    var contaBanco: [Conta] = []
    var contaCartao: [Conta] = []
    var contaInvestimento: [Conta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var conta: Conta
        
        conta = Conta(tipo:0, descricao: "Intermedium", saldo: 13500.00)
        contaBanco.append( conta )
        
        conta = Conta(tipo:0, descricao: "Sofisa", saldo: 250.00)
        contaBanco.append( conta )
        
        conta = Conta(tipo:1, descricao: "Nubank", saldo: -4450.00)
        contaCartao.append( conta )
        
        conta = Conta(tipo:1, descricao: "Digio", saldo: -450.00)
        contaCartao.append( conta )
        
        conta = Conta(tipo:2, descricao: "Tesouro", saldo: 203450.00)
        contaInvestimento.append( conta )
        
        conta = Conta(tipo:2, descricao: "Acoes", saldo: 123140.00)
        contaInvestimento.append( conta )
        
        
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
        let conta: Conta

        if indexPath.section == 0 {
           conta = self.contaBanco[ indexPath.row ]
        }else if indexPath.section == 1 {
           conta = self.contaCartao[ indexPath.row ]
        } else {
            conta = self.contaInvestimento[ indexPath.row ]
        }
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! ContaCelula
        

        celula.contaLabel.text = conta.descricao
        celula.saldoLabel.text = formatCurrency(value: Double(conta.saldo))
        
        return celula
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

