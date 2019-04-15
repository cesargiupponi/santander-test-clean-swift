//
//  StatementTableViewCell.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 13/04/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit

class StatementTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPaymentType: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPaymentDescription: UILabel!
    @IBOutlet weak var labelPaymentValue: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCell() {
        self.view.layer.shadowColor = #colorLiteral(red: 0.8588235294, green: 0.8745098039, blue: 0.8901960784, alpha: 1)
        self.view.layer.shadowOpacity = 1
        self.view.layer.cornerRadius = 6
        self.view.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.view.layer.shadowRadius = 10
    }
    
    func setStatement(statement: Statements.Data.Statement) {
        self.labelPaymentType.text = statement.title
        self.labelDate.text = statement.date?.shortDate
        self.labelPaymentDescription.text = statement.desc
        self.labelPaymentValue.text = statement.value.currency
    }
    
}
