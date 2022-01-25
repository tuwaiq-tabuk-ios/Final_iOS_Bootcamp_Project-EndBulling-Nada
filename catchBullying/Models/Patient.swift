//
//  PatientModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct Patient: Codable {
  @DocumentID var docID: String?
  var id :String
  var nickname: String
  var dateOfBirth: Date?
  var imageURL: String
  var description: String
  var answers: [Int]
}
