//
//  DoctorProfileDetailsViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase

class PatientProfileDetailsViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateOfbirthLabel: UILabel!
  @IBOutlet weak var descriptionField: UITextView!
  
  
  var selectedProfile: Patient?
  
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
   

    super.viewDidLoad()
    
    profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    profileImageView.clipsToBounds = true
    
    if let imgURL = selectedProfile?.imageURL {
      if imgURL != "" {
        profileImageView.load(url: URL(string: imgURL)!)
      }
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let profile = selectedProfile else { return }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    // fill fields
    nicknameLabel.text = profile.nickname
    dateOfbirthLabel.text = dateFormatter.string(from: profile.dateOfBirth ?? Date())
    descriptionField.text = profile.description
  }
  
  // MARK: - IBActions
  @IBAction func closeAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
