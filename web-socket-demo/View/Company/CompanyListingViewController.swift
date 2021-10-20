//
//  ViewController.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/19/21.
//

import UIKit

fileprivate let cellIdentifier = "CompanyTableViewCell"

class CompanyListingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var companies: [Company] = []
    private var presenter: CompanyPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stocks Price"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.presenter = CompanyPresenter(view: self)
        self.presenter.getAllCompanies()
    }
}

extension CompanyListingViewController: ICompanyView {
    func onCompanyListFetched(compnies: [Company]) {
        self.companies = compnies
        self.tableView.reloadData()
        
        presenter.subscribeCompaniesStock(companies: companies)
    }
    
    func onCompanyStockChanged(stock: Stock) {
        // find the index at which the the stock updated and then reload only that cell
        let index = self.companies.lastIndex { (company) -> Bool in company.stock.isin == stock.isin }
        
        if let index = index {
            self.companies[index].stock = stock
            self.tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
        }
    }
}

extension CompanyListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CompanyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(company: self.companies[indexPath.row])
        return cell
    }
}

