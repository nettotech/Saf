//
//  TransacoesViewControler.swift
//  Saf
//
//  Created by Mario Cesar Netto da Silva on 23/05/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import UIKit

class TransacoesViewController: UITableViewController {
 
    //    Transacao(data:Date, descricao: String, comentario: String, valor:Float, saldo:Float){
    
    var transacoes: [Transacao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var transacao: Transacao
        
        transacao = Transacao(data:"03MAI", descricao: "Pagamento conta luz BANDEIRANTE ENERGIA S A", comentario: "#luz # energia", valor: -149.51, saldo: 5340.00)
        transacoes.append( transacao )
        transacao = Transacao(data:"04MAI", descricao: "Pagto conta telefone TELECOMUNICACOES DE", comentario: "## vivo fibra", valor: -124.98, saldo: 5215.02)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Pagamento conta gas COMGAS", comentario: "## gás", valor: -68.68, saldo: 5146.94)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "IOF", comentario: "#taxa", valor: -0.12, saldo: 5146.82)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "IFOOD COM", comentario: "#alimentacao Jantar iFood", valor: -50.90, saldo: 5095.92)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Transferido da poupança 01/01 7027 109826-8 MARIO CESAR NT", comentario: "#transferencia C", valor: 7500.00, saldo: 12595.92)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Cartão 31/12 11:46 ROLDAO SAO JOSE DOS", comentario: "#mercado", valor: -263.93, saldo: 12331.99)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Pagamento recebido", comentario: "## Nubank", valor: -9944.60, saldo: 2387.39)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Google Svcsapps Campu", comentario: "## Google", valor: -23.80, saldo: 2363.59)
        transacoes.append( transacao )
        transacao = Transacao(data:"05MAI", descricao: "Reaiches e Cia", comentario: "#marmitex - Almoço Familia", valor: -29.70, saldo: 2333.89)
        transacoes.append( transacao )
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transacoes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transacao: Transacao
        transacao = self.transacoes[ indexPath.row ]
        let celulaReuso = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! TransacaoCelula
        
        
        celula.dataLabel.text = transacao.data
        celula.descricaoLabel.text = transacao.descricao
        celula.valorLabel.text = formatCurrency(value: Double( transacao.valor ))
        celula.comentarioLabel.text = transacao.comentario
        celula.saldoLabel.text = formatCurrency(value: Double( transacao.saldo ))
        
        return celula
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheTransacao" {
        
            if let indexPath = tableView.indexPathForSelectedRow {
            
                let transacaoSelecionada = self.transacoes[ indexPath.row ]
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
