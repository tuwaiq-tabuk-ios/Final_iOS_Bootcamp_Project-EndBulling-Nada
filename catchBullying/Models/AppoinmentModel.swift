//
//  AppoinmentModel.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct Appointment: Codable {
  @DocumentID var docID: String?
  var patientID: String
  var patientName: String
  var doctorID: String
  var doctorName: String
  var date: Date
  var zoom: Bool
}
