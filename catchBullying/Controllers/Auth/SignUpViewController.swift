import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var userTypePicker: UISegmentedControl!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordText: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  var errorMessage: String = ""
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()


    self.dismissKeyboard()
    passwordTextField.isSecureTextEntry = true
    confirmPasswordText.isSecureTextEntry = true
  }
  
  
  // MARK: - IBIBAction
  @IBAction func signUpButton(_ sender: Any) {
    
    if validateForm() {
    

      Auth
        .auth()
        .createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
        if let error = error {
          if let errCode = AuthErrorCode(rawValue: error._code) {
            switch errCode {
            case .emailAlreadyInUse:
              self.errorLabel.text = "emailAlreadyInUse"
            case .wrongPassword:
              self.errorLabel.text = "wrongPassword"
            case .userNotFound:
              self.errorLabel.text = "userNotFound"
            case .invalidEmail:
              self.errorLabel.text = "invalidEmail"
            default:
              self.errorLabel.text = "Error: \(errCode.rawValue)"
            }
          }
          return
        }
  
        var userModel = UserModel(id: authResult!.user.uid,
                             email: self.emailTextField.text!,
                                  isDoctor: self.userTypePicker.selectedSegmentIndex == 1)
        
        FirestoreRepository.create(collection: "users", document: userModel) { userDocID in
          userModel.docID = userDocID
          user = userModel
          isUpdating = false
          
          if self.userTypePicker.selectedSegmentIndex == 0 {
            var profileModel = PatientModel(id: user.id,
                                            nickname: "",
                                            dateOfBirth: nil,
                                            imageURL: "",
                                            description: "",
                                            answers: [])
            
            FirestoreRepository.create(collection: "patients", document: profileModel) { patientDocID in
              profileModel.docID = patientDocID
              patientProfile = profileModel
              self.performSegue(withIdentifier: "userSignupToQuestions", sender: nil)
            }
          } else {
            var profileModel = DoctorModel(id: user.id,
                                           firstName: "",
                                           lastName: "",
                                           mobileNumber: "",
                                           imageURL: "",
                                           zoom: "",
                                           experience: 0,
                                           languages: [],
                                           availableDates: [], description: "",
                                           answers: [])
            
            FirestoreRepository.create(collection: "doctors", document: profileModel) { doctorDocID in
              profileModel.docID = doctorDocID
              doctorProfile = profileModel
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

