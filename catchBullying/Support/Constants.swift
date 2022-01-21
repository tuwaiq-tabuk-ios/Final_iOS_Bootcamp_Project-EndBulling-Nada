//
//  K.swift
//  catchBullying
//
//  Created by apple on 16/06/1443 AH.
//

import UIKit
import SwiftUI

var user: UserModel!
var patientProfile: PatientModel!
var doctorProfile: DoctorModel!
var profileImage: UIImage?
var isUpdating: Bool = false

struct K {
  
  enum collections: String {
    case users
    case patients
    case doctors
    case conversations
    case appointments
  }
  
  enum segues: String {
    case go_to_PatientProfileDetailsViewController
    case go_to_DoctorProfileDetailsViewController
    case go_to_AppointmentSelectorViewController
    case go_to_VideoPlayerViewController
    case go_to_QuestionsViewController
    case go_to_InformationPatientViewController
    case go_to_ChangeEmailViewController
    case go_to_ChangePasswordViewController
    case go_to_ImportantNumbersViewController
    case go_to_DateSelectorViewController
    case go_to_InformationViewController
    case go_to_ChatViewController
   
  }
  
}
