//
//  MassageCellTableViewCell.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {


  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messageBubble: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
   

        // Initialization code
    }
  
  public func configure(message: MessageModel) {
    if message.sender == user.id {
      messageBubble.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMaxYCorner]
      messageLabel.textAlignment = .right
      messageBubble.backgroundColor = .init(named: "accentColor")
    } else {
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
      messageLabel.textAlignment = .left
      messageBubble.backgroundColor = .systemGray5
    }
    messageLabel.text = message.content
    messageBubble.layer.cornerRadius = messageLabel.frame.height / 2
    
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
