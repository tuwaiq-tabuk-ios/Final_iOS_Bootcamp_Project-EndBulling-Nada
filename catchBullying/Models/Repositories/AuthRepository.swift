//
//  AuthRepository.swift
//  catchBullying
//
//  Created by apple on 16/06/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthRepository {
  
  let auth = Auth.auth()
  static let shared = AuthRepository()
  
  public func createUser(email: String, password: String, completion: @escaping (String?, User?) -> ()) {
    auth.createUser(withEmail: email, password: password) { authResult, error in
      if let error = error {
        if let errCode = AuthErrorCode(rawValue: error._code) {
          switch errCode {
          case .emailAlreadyInUse: completion("emailAlreadyInUse", nil)
          case .wrongPassword: completion("wrongPassword", nil)
          case .userNotFound: completion("userNotFound", nil)
          case .invalidEmail: completion("invalidEmail", nil)
          default: completion("Error: \(errCode.rawValue)", nil)
          }
        }
        return
      } else {
        completion(nil, authResult?.user)
      }
    }
  }
  
  public func signIn(email: String, password: String, completion: @escaping (String?, User?) -> ()) {
    auth.signIn(withEmail: email, password: password) { authResult, error in
      if let error = error {
        if let errCode = AuthErrorCode(rawValue: error._code) {
          switch errCode {
          case .emailAlreadyInUse: completion("emailAlreadyInUse", nil)
          case .wrongPassword: completion("wrongPassword", nil)
          case .userNotFound: completion("userNotFound", nil)
          case .invalidEmail: completion("invalidEmail", nil)
          default: completion("Error: \(errCode.rawValue)", nil)
          }
        }
        return
      } else {
        completion(nil, authResult?.user)
      }
    }
  }
  
}
