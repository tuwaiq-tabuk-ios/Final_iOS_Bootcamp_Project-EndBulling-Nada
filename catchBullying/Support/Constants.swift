//
//  K.swift
//  catchBullying
//
//  Created by apple on 16/06/1443 AH.
//

import UIKit
import SwiftUI

var user: FirestoreUser!
var patientProfile: Patient!
var doctorProfile: Doctor!
var profileImage: UIImage?
var isUpdating: Bool = false

struct K {
  
  struct Collections {
    static var users = "users"
    static var patients = "patients"
    static var doctors = "doctors"
    static var conversations = "conversations"
    static var appointments = "appointments"
  }
  
  struct Segues {
    static var go_to_PatientProfileDetailsViewController = "go_to_PatientProfileDetailsViewController"
    static var go_to_DoctorProfileDetailsViewController = "go_to_DoctorProfileDetailsViewController"
    static var go_to_AppointmentSelectorViewController = "go_to_AppointmentSelectorViewController"
    static var go_to_VideoPlayerViewController = "go_to_VideoPlayerViewController"
    static var go_to_QuestionsViewController = "go_to_QuestionsViewController"
    static var go_to_InformationPatientViewController = "go_to_InformationPatientViewController"
    static var go_to_ChangeEmailViewController = "go_to_ChangeEmailViewController"
    static var go_to_ChangePasswordViewController = "go_to_ChangePasswordViewController"
    static var go_to_ImportantNumbersViewController = "go_to_ImportantNumbersViewController"
    static var go_to_DateSelectorViewController = "go_to_DateSelectorViewController"
    static var go_to_InformationViewController = "go_to_InformationViewController"
    static var go_to_ChatViewController = "go_to_ChatViewController"
  }
  
}
