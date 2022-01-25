//
//  UserModel.swift
//  catchBullying
//
//  Created by apple on 14/05/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct FirestoreUser: Codable, Equatable {
  @DocumentID var docID: String?
  var id: String
  var email: String
  var isDoctor: Bool
}
