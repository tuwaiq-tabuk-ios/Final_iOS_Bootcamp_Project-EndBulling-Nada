//
//  MassageCellTableViewCell.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messagebubble: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
