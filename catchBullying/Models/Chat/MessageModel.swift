//
//  MessageModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct MessageModel: Codable {
  var id: UUID
  var content: String
  var received: Bool
  var sender: String
  var sentAt = Date()
}
