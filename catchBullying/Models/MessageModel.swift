//
//  MessageModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import Foundation

struct MessageModel: Codable {
  var senderID: String
  var receiverID: String
  var message: String
}
