//
//  InformationVC.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class InformationVC: UIViewController, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView:         UIImageView!
  @IBOutlet weak var firstNameField:    UITextField!
  @IBOutlet weak var lastNameField:     UITextField!
  @IBOutlet weak var mobileNumberField: UITextField!
  @IBOutlet weak var emailField:        UITextField!
  @IBOutlet weak var zoomField:         UITextField!
  @IBOutlet weak var languagesField:    UITextField!
  @IBOutlet weak var experienceField:   UITextField!
  @IBOutlet weak var descriptionField:  UITextView!
  
  let imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dismissKeyboard()
    imagePicker.delegate = self
    
    imageView.layer.cornerRadius = imageView.frame.size.height / 2
    imageView.clipsToBounds = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
    imageView.addGestureRecognizer(tap)
    imageView.isUserInteractionEnabled = true
    
    if !doctorProfile.imageURL.isEmpty {
      let ref = Storage.storage().reference(forURL: doctorProfile.imageURL)
          ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print(error.localizedDescription)
              } else if let data = data, let image = UIImage(data: data) {
                self.imageView.image = image
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
  
  private func saveProfileImageUrlInUserDetails(url: String) {
    doctorProfile.imageURL = url
    
    let db = Firestore.firestore()
    do {
      try db.collection("doctors").document(doctorProfile.docID!).setData(from: doctorProfile, merge: true) { error in
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
    guard let experience = experienceField.text else {return}
    guard let experienceInt = Int(experience) else { return }
    guard let description = descriptionField.text else { return }
    
    guard !firstName.isEmpty ,
          !lastName.isEmpty ,
          !mobileNumber.isEmpty ,
          !zoom.isEmpty ,
          !experience.isEmpty,
          !description.isEmpty else{
            return
          }
    
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

extension InformationVC: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 0.1) {
      imageView.image = image
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
