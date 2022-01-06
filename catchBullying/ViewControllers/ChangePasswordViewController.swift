//
//  ChangePasswordViewController.swift
//  catchBullying
//
//  Created by apple on 03/06/1443 AH.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {
  
  @IBOutlet weak var changePasswordLabel: UILabel!
  @IBOutlet weak var oldPassword: UITextField!
  @IBOutlet weak var newPassword
  : UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  @IBAction func changePasswordAction(_ sender: Any) {
    guard let password = newPassword.text ,
          let oldpassword = oldPassword.text ,
          password == oldpassword
    else{return}
    Auth.auth().currentUser?.updatePassword(to: password , completion: { error in
      if let error = error {
        print(error.localizedDescription)
        
      }
      self.dismiss(animated: true, completion: nil)
    })
    
  }
  
  
  
}
