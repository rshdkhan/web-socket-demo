//
//  StockTableViewCell.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/19/21.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func configure(company: Company) {
        self.lblTitle.text = company.title
        self.lblPrice.text = company.stock.price.formate()
    }
}
