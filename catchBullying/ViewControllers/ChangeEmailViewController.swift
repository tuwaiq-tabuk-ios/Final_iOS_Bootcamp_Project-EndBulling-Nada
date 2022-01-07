//
//  ChangeEmailViewController.swift
//  catchBullying
//
//  Created by apple on 03/06/1443 AH.
//

import UIKit
import FirebaseAuth

class ChangeEmailViewController: UIViewController {
  
  @IBOutlet weak var changeEmail: UILabel!
  @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  @IBAction func changeEmailActione(_ sender: Any) {
    guard let email = emailField.text else { return }
    
    Auth.auth().currentUser?.updateEmail(to: email, completion: { error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      self.dismiss(animated: true, completion: nil)
    })
  }

}
