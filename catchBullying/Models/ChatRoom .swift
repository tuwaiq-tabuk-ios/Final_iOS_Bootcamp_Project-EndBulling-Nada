//
//  ChatRoom .swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct ChatRoom : Codable  {
  var id = ""
  var chatRoomId = ""
  var senderName = ""
  var receiverId = ""
  var receiverName = ""
//  @ServerTimestamp var data = Data()
  var data = Data()
  var memberId = [""]
  var lastMessage = ""
  var unreadCounter = 0
  var avatarLink = ""
  
}
