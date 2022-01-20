//
//  FSUserManager.swift
//  catchBullying
//
//  Created by apple on 16/06/1443 AH.
//

import Foundation
import Firebase

class FSUserManager {
  
  static let shared = FSUserManager()
  
  func signUpWith(email: String,
                  password: String,
                  completion: @escaping (_ error: Error?) -> ()) {
    Auth.auth().createUser(withEmail: email,
                           password: password) { authResult, error in
      if let error = error {
        completion(error)
      } else {
        completion(error)
      }
    }
  }
}
