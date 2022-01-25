//
//  File.swift
//  catchBullying
//
//  Created by apple on 01/06/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift


// contains users and messages

struct ConversationUser: Codable {
  var id: String
  var name: String
  var imageURL: String?
}
struct ConversationModel: Codable {
  @DocumentID var docID: String?
  var messages: [Message]
  var usersIDs: [String]
  var users: [ConversationUser]
}
