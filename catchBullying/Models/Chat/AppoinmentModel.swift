//
//  AppoinmentModel.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import Foundation

struct AppointmentModel: Codable {
  var patientID: String
  var patientName: String
  var doctorID: String
  var doctorName: String
  var date: Date
}
