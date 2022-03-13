//
//  TransactionTableViewCell.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var receipName: UILabel!
  @IBOutlet weak var receipNumber: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureCell(with data: TransactionModel) {
    self.receipName.text = data.receipient.accHolder
    self.receipNumber.text = data.receipient.accNumber
    self.amountLabel.text = data.type == "received" ? data.amount : "- " + data.amount
    self.amountLabel.textColor = data.type == "received" ? .systemGreen : Constants.Color.secondaryText
  }
}
