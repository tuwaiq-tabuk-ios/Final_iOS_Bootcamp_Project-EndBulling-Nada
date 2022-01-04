//
//  PatientModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import Foundation

struct PatientModel: Codable {
  var id :String
  var nickname: String
  var dateOfBirth: Date?
  var imageURL: String
  var description: String
  var answers: [Int]
}
