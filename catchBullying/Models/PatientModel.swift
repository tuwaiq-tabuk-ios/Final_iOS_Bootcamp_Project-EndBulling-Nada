//
//  PatientModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import Foundation

struct PatientModel: Codable {
  var id :String
  var firstName :String
  var lastName :String
  var mobileNumber : String
  var answers: [Int]
}
