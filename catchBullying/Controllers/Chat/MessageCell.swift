//
//  MassageCellTableViewCell.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {

  // MARK: - IBOutlets
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messageBubble: UIView!
  
  // MARK: - View controller lifecycle
  override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  public func configure(message: Message) {
    if message.sender == user.id {
      //messageBubble.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMaxYCorner]
      messageLabel.textAlignment = .right
      messageBubble.backgroundColor = .init(named: "accentColor")
    } else {
      //messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
      messageLabel.textAlignment = .left
      messageBubble.backgroundColor = .systemGray5
    }
    messageLabel.text = message.content
    //messageBubble.layer.cornerRadius = messageBubble.frame.height / 2
    
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
