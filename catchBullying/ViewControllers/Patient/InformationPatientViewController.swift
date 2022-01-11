//
//  InformationPatienViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class InformationPatientViewController: UIViewController, UINavigationControllerDelegate {
  

  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nicknameField: UITextField!
  @IBOutlet weak var dateOfBirthField: UITextField!
  @IBOutlet weak var decriptionField: UITextView!
  
  let datePicker = UIDatePicker()
  let imagePicker = UIImagePickerController()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dismissKeyboard()
    createDatePiker()
    imagePicker.delegate = self
    
    profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    profileImageView.clipsToBounds = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
    profileImageView.addGestureRecognizer(tap)
    profileImageView.isUserInteractionEnabled = true
    
    if !patientProfile.imageURL.isEmpty {
      let ref = Storage.storage().reference(forURL: patientProfile.imageURL)
          ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print(error.localizedDescription)
              } else if let data = data, let image = UIImage(data: data) {
                self.profileImageView.image = image
              }
          }
    }
  }
  
  @objc func pickImage() {
    
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
      self.openCamera()
    }))
    
    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
      self.openGallary()
    }))
    
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    
    /*If you want work actionsheet on ipad
     then you have to use popoverPresentationController to present the actionsheet,
     otherwise app will crash on iPad */
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      alert.popoverPresentationController?.sourceView = view
      alert.popoverPresentationController?.sourceRect = view.bounds
      alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
      break
    }
    
    self.present(alert, animated: true, completion: nil)
  }
  
  func openCamera()
  {
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
    {
      imagePicker.sourceType = UIImagePickerController.SourceType.camera
      imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
    }
    else
    {
      let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  func openGallary()
  {
    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
    imagePicker.allowsEditing = true
    self.present(imagePicker, animated: true, completion: nil)
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
    guard
      !nickname.isEmpty,
      !dateOfBirth.isEmpty,
      !description.isEmpty else {
        return
      }
    
    
    
    
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
  
  private func saveProfileImageUrlInUserDetails(url: String) {
    patientProfile.imageURL = url
    
    let db = Firestore.firestore()
    do {
      try db.collection("patients").document(patientProfile.docID!).setData(from: patientProfile, merge: true) { error in
        if let error = error {
          fatalError()
        }
        print("updated")
        //patientProfile = updatedProfile
        //self.navigationController?.dismiss(animated: true, completion: nil)
      }
    } catch {
      fatalError()
    }
  }
  
}

extension InformationPatientViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 0.1) {
      profileImageView.image = image
      let storageRef = Storage.storage().reference().child("profileImages").child("\(user.id).jpeg")
      let metaData = StorageMetadata()
      metaData.contentType = "image/jpeg"
      storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
        if error == nil, metaData != nil {
          storageRef.downloadURL { url, error in
            if let url = url {
              print(url)//URL of the profile image
              self.saveProfileImageUrlInUserDetails(url: url.absoluteString)
            }
          }
        } else {
          print(error?.localizedDescription)//upload failed
        }
      }
    }
    picker.dismiss(animated: true, completion: nil)
  }
}
