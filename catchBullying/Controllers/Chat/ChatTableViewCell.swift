
//  ChatRoomTableViewCell.swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.


import UIKit

class ChatTableViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var avatarImagwOutLet: UIImageView!
  @IBOutlet weak var usernameLabelOutlet: UILabel!
  @IBOutlet weak var lastMessageLabelOutlet: UILabel!
  @IBOutlet weak var dateMessageLabelOutlet: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - Methods
  func configure (conversation: ConversationModel) {
    usernameLabelOutlet.text = conversation.users.first(where: { $0.id != user.id })?.name
    usernameLabelOutlet.minimumScaleFactor = 0.9
    lastMessageLabelOutlet.text = conversation.messages.last?.content
    lastMessageLabelOutlet.numberOfLines = 2
    dateMessageLabelOutlet.text = timeElapsed(date: conversation.messages.last?.sentAt ?? Date())
    usernameLabelOutlet.minimumScaleFactor = 0.9
    avatarImagwOutLet.layer.cornerRadius = avatarImagwOutLet.frame.width / 2
    if let imageURL = conversation.users.first(where: { $0.id != user.id })?.imageURL {
      if imageURL != "" {
        avatarImagwOutLet.load(url: URL(string: imageURL)!)
      }
    }
    
    
    func timeElapsed ( date : Date ) -> String {
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm d/M/y"
      return formatter.string(from: date)
    }
    
  }
  
}


// MARK: - extension

extension Date {
  
  func lognDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MM yyyy"
    return dateFormatter.string(from: self)
  }
  
}

