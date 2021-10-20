//
//  CompanyPresenter.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/20/21.
//

import Foundation


protocol ICompanyView: class {
    func onCompanyListFetched(compnies: [Company])
    func onCompanyStockChanged(stock: Stock)
}

final class CompanyPresenter {
    let view: ICompanyView
    
    init(view: ICompanyView) {
        self.view = view
    }
    
    func getAllCompanies() {
        // hardcoded companies
        let compnies = [
            Company(title: "Facebook", stock: Stock(isin: "US30303M1027", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "PayPal", stock: Stock(isin: "US70450Y1038", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Tesla Motors", stock: Stock(isin: "US88160R1014", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "BASF", stock: Stock(isin: "DE000BASF111", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Wirecard", stock: Stock(isin: "DE0007472060", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Uber", stock: Stock(isin: "US90353T1007", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Amazon", stock: Stock(isin: "US0231351067", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "System Limited", stock: Stock(isin: "PK0109001013", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Apple", stock: Stock(isin: "US0378331005", price: 0.0, bid: 0.0, ask: 0.0)),
            Company(title: "Google", stock: Stock(isin: "US38259P5089", price: 0.0, bid: 0.0, ask: 0.0)),
        ]
        
        self.view.onCompanyListFetched(compnies: compnies)
    }
    
    func subscribeCompaniesStock(companies: [Company]) {
        SocketManager.shared.connect(type: Stock.self) { (response) in
            switch response.eventType {
            
            case .connected:
                
                for company in companies {
                    SocketManager.shared.subscribe(companyISIN: company.stock.isin)
                }
            
                break
                
            case .disconnected:
                break
                
            case .valueChange:
                guard let stock = response.data else { return }
                self.view.onCompanyStockChanged(stock: stock)
                break
                
            case .error:
                break
                
            case .other:
                break
            }
        }
    }
}
