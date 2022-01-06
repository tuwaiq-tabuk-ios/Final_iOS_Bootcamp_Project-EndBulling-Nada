//
//  InformationPatienViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class InformationPatientViewController: UIViewController {
  
  @IBOutlet weak var nicknameField: UITextField!
  @IBOutlet weak var dateOfBirthField: UITextField!
  @IBOutlet weak var decriptionField: UITextView!
  
  let datePicker = UIDatePicker()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createDatePiker()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    nicknameField.text = patientProfile.nickname
    dateOfBirthField.text = dateFormatter.string(from: patientProfile.dateOfBirth ?? Date())
    decriptionField.text = patientProfile.description
  }
  
  func createToolbar() -> UIToolbar {
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed))
    
    toolbar.setItems([doneBtn], animated: true)
    
    return toolbar
  }
  
  func createDatePiker(){
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date
    dateOfBirthField.inputView = datePicker
    dateOfBirthField.inputAccessoryView = createToolbar()
  }
  
  
  @IBAction func closeAction(_ sender: Any) {
    navigationController?.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveAction(_ sender: Any) {
    
    guard let nickname = nicknameField.text else { return }
    guard let dateOfBirth = dateOfBirthField.text else { return }
    guard let description = decriptionField.text else { return }
    
    let updatedProfile = PatientModel(id: patientProfile.id,
                                      nickname: nickname,
                                      dateOfBirth: datePicker.date,
                                      imageURL: "",
                                      description: description,
                                      answers: [])
    
    let db = Firestore.firestore()
    do {
      try db.collection("patients").document(patientProfile.docID!).setData(from: updatedProfile, merge: true) { error in
        if let error = error {
          fatalError()
        }
        print("updated")
        patientProfile = updatedProfile
        self.navigationController?.dismiss(animated: true, completion: nil)
      }
    } catch {
      fatalError()
    }
    
    
  }
  
  @objc func donePressed() {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    self.dateOfBirthField.text = dateFormatter.string(from:datePicker.date)
    self.view.endEditing(true)
    
  }
  
}
