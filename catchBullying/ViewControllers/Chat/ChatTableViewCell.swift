
//  ChatRoomTableViewCell.swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.


import UIKit

class ChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var avatarImagwOutLet: UIImageView!
  @IBOutlet weak var usernameLabelOutlet: UILabel!
  @IBOutlet weak var lastMessageLabelOutlet: UILabel!
  @IBOutlet weak var dateMessageLabelOutlet: UILabel!
  @IBOutlet weak var unreadCounterLabelOutlet: UILabel!
  @IBOutlet weak var unreadCounterViewOutlet: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
 

    // Initialization code
    unreadCounterViewOutlet.layer.cornerRadius = unreadCounterViewOutlet.frame.width/2
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure (conversation: ConversationModel) {
    // TODO
    usernameLabelOutlet.text = conversation.users.first(where: { $0.id != user.id })?.name
    usernameLabelOutlet.minimumScaleFactor = 0.9
    lastMessageLabelOutlet.text = conversation.messages.last?.content
    lastMessageLabelOutlet.numberOfLines = 2
    dateMessageLabelOutlet.text = timeElapsed(date: conversation.messages.last?.sentAt ?? Date())
    unreadCounterLabelOutlet.text = "\(conversation.messages.filter({ $0.received == false }).count)"
    usernameLabelOutlet.minimumScaleFactor = 0.9
    avatarImagwOutLet.layer.cornerRadius = unreadCounterViewOutlet.frame.width/2
    //    dateMessageLabelOutlet.text = timeElapsed(timeElapsed.data ?? Date())
//    if chatRoom.unreadCounter != 0 {
//      self.unreadCounterLabelOutlet.text = "\(chatRoom.unreadCounter)"
//      self.unreadCounterViewOutlet.isHidden = false
//    } else {
//      self.unreadCounterViewOutlet.isHidden = true
//
//    }
    
    
    
    
    func timeElapsed ( date : Date ) -> String {
      let seconds = Date () .timeIntervalSince(date)
      var elapsed = ""
      
      if seconds < 60 {
        elapsed = "Just now "
      }
      
      else if seconds < 60 * 60 {
        let minutes = Int(seconds/60)
        let minText = minutes > 1 ? "mins" : "min"
        elapsed = "\(minutes) \(minText) "
        
      }
      else if seconds < 24 * 60 * 60 {
        let hours = Int(seconds / (60 * 60))
        let hourText = hours > 1 ? "hours" : "hours"
        elapsed = "\(hours) \(hourText)"
        
      }
      
      else {
        elapsed = "\(date)"
        
        
      }
      
      return elapsed
      
    }
    
  }
  
}



extension Date {
  
  func lognDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MM yyyy"
    return dateFormatter.string(from: self)
  }
  
}

