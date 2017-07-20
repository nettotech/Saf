//
//  CoreDataSaf.swift
//  Saf
//
//  Created by Mario on 26/06/17.
//  Copyright © 2017 Mario Cesar Netto da Silva. All rights reserved.
//

import UIKit
import CoreData

class CoreDataSaf {
    
    //recuperar o context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func retrieveTransactionsAccount(accountID: String) -> [Transactions] {
        
        let context = self.getContext()
        
        let requisicao = Transactions.fetchRequest() as NSFetchRequest<Transactions>
        requisicao.predicate = NSPredicate(format: "accountID = %@", accountID as CVarArg )
//        requisicao.predicate = NSPredicate(format: "accountID = %@", "1" )
        
        do{
            
            let transactions = try context.fetch(requisicao) as [Transactions]

            if transactions.count == 0 {
                self.addAllTransactions()
                return self.retrieveTransactionsAccount(accountID: accountID)
            }
            
            return transactions
            
        }catch{}
        
        
        return []
        
    }
    
    func retrieveAllAccounts() -> [Accounts] {
        
        let context = self.getContext()

        let requisicao = Accounts.fetchRequest() as NSFetchRequest<Accounts>
        requisicao.predicate = NSPredicate(format: "accountDeleted <> 1")
        
        do{
            let accounts = try context.fetch(requisicao) 
            
            if accounts.count == 0 {
                self.addAllAccounts()
                return self.retrieveAllAccounts()
            }
            
            return accounts
        }catch{}
        
        return []
        
    }

    func retrieveAllTransactions() -> [Transactions] {
        
        let context = self.getContext()
        
        do{
            let transactions = try context.fetch( Transactions.fetchRequest() ) as! [Transactions]
            
            if transactions.count == 0 {
                self.addAllTransactions()
                return self.retrieveAllTransactions()
            }
            
            return transactions
        }catch{}
        
        return []
        
    }
    
    func saveAccounts( account: Accounts ){
        
        let context = self.getContext()
        account.type = 0
        
        do{
            try context.save()
        }catch{}
        
    }
    
    //adicionar todos as contas
    func addAllAccounts(){
        
        let context = self.getContext()
        
        self.createAccount(accountID:1, accountName: "Intermedium", type:0, balance:13500.00 )
        self.createAccount(accountID:2, accountName: "Sofisa", type:0, balance:250.00 )
        self.createAccount(accountID:3, accountName: "Nubank", type:1, balance:-4450.00 )
        self.createAccount(accountID:4, accountName: "Digio", type:1, balance:-450.0 )
        self.createAccount(accountID:5, accountName: "Tesouro", type:2, balance:203450.00  )
        self.createAccount(accountID:6, accountName: "Acoes", type:2, balance:123140.00 )
        
        do{
            try context.save()
        }catch{}
        
    }

    //adicionar todos as transacoes
    func addAllTransactions(){
        
        let context = self.getContext()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.createTransaction(transactionID: 1, accountID: 1, ammount: -149.51, categoryID: 1, comments: "#luz # energia", date: dateFormatter.date(from: "03/05/2017")!, transaction_description: "Pagamento conta luz BANDEIRANTE ENERGIA S A", type: 1)
        self.createTransaction(transactionID: 2, accountID: 1, ammount: -124.98, categoryID: 1, comments: "### vivo fibra", date: dateFormatter.date(from: "04/05/2017")!, transaction_description: "Pagto conta telefone TELECOMUNICACOES DE", type: 1)
        self.createTransaction(transactionID: 3, accountID: 1, ammount: -68.68, categoryID: 1, comments: "#luz # energia", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Pagamento conta gas COMGAS", type: 1)
        self.createTransaction(transactionID: 4, accountID: 2, ammount: -0.12, categoryID: 1, comments: "#taxa", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "IOF", type: 1)
        self.createTransaction(transactionID: 5, accountID: 2, ammount: -50.90, categoryID: 1, comments: "#alimentacao Jantar iFood", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "IFOOD COM", type: 1)
        self.createTransaction(transactionID: 6, accountID: 2, ammount: 7500.00, categoryID: 1, comments: "#transferencia C", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Transferido da poupança 01/01 7027 109826-8 MARIO CESAR NT", type: 1)
        self.createTransaction(transactionID: 7, accountID: 3, ammount: -9944.60, categoryID: 1, comments: "## Nubank", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Pagamento recebido", type: 1)
        self.createTransaction(transactionID: 8, accountID: 3, ammount: -263.93, categoryID: 1, comments: "#mercado", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Cartão 31/12 11:46 ROLDAO SAO JOSE DOS", type: 1)
        self.createTransaction(transactionID: 9, accountID: 3, ammount: -23.80, categoryID: 1, comments: "## Google", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Google Svcsapps Campu", type: 1)
        self.createTransaction(transactionID: 10, accountID: 3, ammount: -29.70, categoryID: 1, comments: "#marmitex - Almoço Familia", date: dateFormatter.date(from: "05/05/2017")!, transaction_description: "Reaiches e Cia", type: 1)
                
        do{
            try context.save()
        }catch{}
        
    }
    
    
    //apagando todos os dados de uma tabela
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    //criar as Contas
    func createAccount(accountID: Int16, accountName: String, type: Int16, balance: Float){
        
        let context = self.getContext()
        let account = Accounts(context: context )
        account.accountID = accountID
        account.accountName = accountName
        account.type = type
        account.balance = balance
    }

    func updateAccount(account: Accounts, accountName: String, type: String, balance: String){

        let context = self.getContext()
        account.accountName = accountName
        account.type = Int16(type)!
        account.balance = Float(balance)!
        
        do{
            try context.save()
        }catch{}
    }
    
    func addAccount(accountName: String, type: String){ 
        
        let context = self.getContext()
        let account = Accounts(context: context )
        
        account.accountID = retrieveNextAccountID()
        account.accountName = accountName
        account.type = Int16(type)!
        
        do{
            try context.save()
        }catch{}
    }

    func retrieveNextAccountID() -> Int16 {
        
        var accountMax : (Int16) = 0
        var accounts: [Accounts] = []
        accounts = retrieveAllAccounts()
        
        for account in accounts {
            if account.accountID > accountMax {
                accountMax = account.accountID
            }
        }
        
        accountMax += 1
        
        return accountMax
        
    }
    
    func deleteAccount(account: Accounts){
        
        let context = self.getContext()

        account.accountDeleted = 1
//        context.delete( account )
        
        do{
            try context.save()
        }catch{}
    }

    
    func createTransaction(transactionID: Int16, accountID: Int16, ammount: Float, categoryID: Int16, comments: String, date: Date, transaction_description: String, type: Int16){
        
        let context = self.getContext()
        let transaction = Transactions(context: context )
        transaction.transactionID = transactionID
        transaction.accountID = accountID
        transaction.ammount = ammount
        transaction.categoryID = categoryID
        transaction.comments = comments
        transaction.date = date as NSDate
        transaction.transaction_description = transaction_description
        transaction.type = type
    }

    func updateTransaction(transaction: Transactions, accountID: Int16, ammount: String, categoryID: Int16, comments: String, date: String, transaction_description: String, type: Int16){
    
        let context = self.getContext()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        
        transaction.accountID = accountID
        transaction.ammount = Float(ammount)!
        transaction.categoryID = categoryID
        transaction.comments = comments
        transaction.date = dateFormatter.date(from: date)! as NSDate
        transaction.transaction_description = transaction_description
        transaction.type = type
        
        do{
            try context.save()
        }catch{}
    }
    
    func addTransaction(ammount: String, comments: String, date: String, transaction_description: String){
        
        let context = self.getContext()
        let transaction = Transactions(context: context )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        transaction.transactionID = retrieveNextAccountID()
        transaction.accountID = 1
        transaction.ammount = Float(ammount)!
        transaction.categoryID = 1
        transaction.comments = comments
        transaction.date = dateFormatter.date(from: date)! as NSDate
        transaction.transaction_description = transaction_description
        transaction.type = 1
        
        do{
            try context.save()
        }catch{}
    }
    
    func retrieveNextTransactionID() -> Int16 {
        
        var transactionMax : (Int16) = 0
        var transactions: [Transactions] = []
        transactions = retrieveAllTransactions()
        
        for transaction in transactions {
            if transaction.transactionID > transactionMax {
                transactionMax = transaction.transactionID
            }
        }
        
        transactionMax += 1
        
        return transactionMax
        
    }
    
    func deleteTransaction(transaction: Transactions){
        
        let context = self.getContext()
        
        // transaction.accountDeleted = 1
        context.delete( transaction )
        
        do{
            try context.save()
        }catch{}
    }

    
}
