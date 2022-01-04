//
//  DoctorModel.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct DoctorModel: Codable {
  @DocumentID var docID: String?
  var id :String
  var firstName :String
  var lastName :String
  var mobileNumber : String
  var imageURL: String
  var zoom: String
  var experience: Int
  var languages: [String]
  var description: String
  var answers: [Int]
  
}
