//
//  InformationVC.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class InformationVC: UIViewController {
  
  @IBOutlet weak var imageView:         UIImageView!
  @IBOutlet weak var firstNameField:    UITextField!
  @IBOutlet weak var lastNameField:     UITextField!
  @IBOutlet weak var mobileNumberField: UITextField!
  @IBOutlet weak var emailField:        UITextField!
  @IBOutlet weak var zoomField:         UITextField!
  @IBOutlet weak var languagesField:    UITextField!
  @IBOutlet weak var experienceField:   UITextField!
  @IBOutlet weak var descriptionField:  UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    firstNameField.text = doctorProfile.firstName
    lastNameField.text = doctorProfile.lastName
    mobileNumberField.text = doctorProfile.mobileNumber
    zoomField.text = doctorProfile.zoom
    experienceField.text = "\(doctorProfile.experience)"
    descriptionField.text = doctorProfile.description
  }
  
  
  
  
  @IBAction func closeAction(_ sender: Any) {
    navigationController?.dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
  
  @IBAction func saveAction(_ sender: Any) {
    
    guard let firstName = firstNameField.text else { return }
    guard let lastName = lastNameField.text else {return}
    guard let mobileNumber = mobileNumberField.text else {return}
    guard let zoom = zoomField.text else {return}
    //guard let languages = languagesField.text else {return}
    guard let experience = experienceField.text else {return}
    guard let experienceInt = Int(experience) else { return }
    guard let description = descriptionField.text else { return }
    
    let updatedProfile = DoctorModel(docID: doctorProfile.docID,
      id: doctorProfile.id,
                                     firstName: firstName,
                                     lastName: lastName,
                                     mobileNumber: mobileNumber,
                                     imageURL: "",
                                     zoom: zoom,
                                     experience: experienceInt,
                                     languages: [],
                                     availableDates: [], description: description,
                                     answers: doctorProfile.answers)
    
    let db = Firestore.firestore()
    do {
      try db.collection("doctors").document(doctorProfile.docID!).setData(from: updatedProfile, merge: true) { error in
        if let error = error {
          fatalError()
        }
        print("updated")
        doctorProfile = updatedProfile
        self.navigationController?.dismiss(animated: true, completion: nil)
      }
    } catch {
      fatalError()
    }
    
    
    
  }
  
  
}
