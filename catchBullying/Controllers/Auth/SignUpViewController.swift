import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
  
  // MARK: - IBOutlets

  @IBOutlet weak var userTypePicker: UISegmentedControl!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordText: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  // MARK: - Properties
  var errorMessage: String = ""
  
  
  
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    
    super.viewDidLoad()


    self.dismissKeyboard()
    passwordTextField.isSecureTextEntry = true
    confirmPasswordText.isSecureTextEntry = true
  }
  
  
  // MARK: - IBAction
  @IBAction func signUpButtonPressed(_ sender: Any) {
    
    if validateForm() {
      self.startLoading()
      AuthRepository.shared.createUser(email: emailTextField.text!,
                                       password: passwordTextField.text!) { error, usr in
        if let error = error {
          self.errorLabel.text = error
          self.stopLoading()
        } else {
          guard let usr = usr else { return }
          var userModel = FirestoreUser(id: usr.uid,
                               email: self.emailTextField.text!,
                                    isDoctor: self.userTypePicker.selectedSegmentIndex == 1)
          
          FirestoreRepository.shared.create(collection: K.Collections.users, document: userModel) { userDocID in
            userModel.docID = userDocID
            user = userModel
            isUpdating = false
            
            if self.userTypePicker.selectedSegmentIndex == 0 {
              var profileModel = Patient(id: user.id,
                                              nickname: "",
                                              dateOfBirth: nil,
                                              imageURL: "",
                                              description: "",
                                              answers: [])
              
              FirestoreRepository.shared.create(collection: K.Collections.patients, document: profileModel) { patientDocID in
                profileModel.docID = patientDocID
                patientProfile = profileModel
                self.stopLoading()
                self.performSegue(withIdentifier: K.Segues.go_to_QuestionsViewController, sender: nil)
              }
            } else {
              var profileModel = Doctor(id: user.id,
                                             firstName: "",
                                             lastName: "",
                                             mobileNumber: "",
                                             imageURL: "",
                                             zoom: "",
                                             experience: 0,
                                             languages: [],
                                             availableDates: [], description: "",
                                             answers: [])
              
              FirestoreRepository.shared.create(collection: K.Collections.doctors, document: profileModel) { doctorDocID in
                profileModel.docID = doctorDocID
                doctorProfile = profileModel
                self.stopLoading()
                let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeTabBarController
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .flipHorizontal
                self.present(controller, animated: false, completion: nil)
              }
            }
          }
        }
      }
    }
  }
  
  
  // MARK: - Methods
  func validateForm() ->Bool {
    if emailTextField.text!.isEmpty {
      errorLabel.text = "Email Addressis Missing!"
      return false
    }
    
    if passwordTextField.text!.isEmpty {
      errorLabel.text = "Password Missing!"
      return false
    }
    
    if confirmPasswordText.text!.isEmpty {
      errorLabel.text = "Password Confirmation Missing!"
      return false
    }
    
    if passwordTextField.text!.count < 8 {
      errorLabel.text = "Password too short!"
      return false
    }
    
    if passwordTextField.text != confirmPasswordText.text {
      errorLabel.text = "Password Does Not Match"
      return false
    }
    if !emailTextField.text!.contains("@") {
      errorLabel.text = "Email invalid"
      return false
    }
    errorLabel.text = ""
    return true
    
  }
  
}

