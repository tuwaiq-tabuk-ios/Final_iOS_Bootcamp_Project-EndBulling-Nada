//
//  CalendarCell.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit

class CalendarCell: UITableViewCell {

  
  // MARK: - IBOutlets

  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var zoomLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
