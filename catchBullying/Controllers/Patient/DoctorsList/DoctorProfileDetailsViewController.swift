//
//  DoctorProfileDetailsViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase

class DoctorProfileDetailsViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var providesAdviceLabel: UILabel!
  @IBOutlet weak var experienceLabel: UILabel!
  @IBOutlet weak var zommLabel: UILabel!
  
  
  
  // MARK: - View controller lifecycle
  var selectedProfile: DoctorModel?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    imageView.clipsToBounds = true
    
    if !selectedProfile!.imageURL.isEmpty {
      self.imageView.load(url: URL(string: selectedProfile!.imageURL)!)
    }
  }
  
  
//  MARK: - IBAction
  @IBAction func closePressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - View controller lifecycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let profile = selectedProfile else { return }
    
    
    // fill fields
    nameLabel.text = profile.firstName + " " + profile.lastName
    informationLabel.text = profile.description
    //    providesAdviceLabel.text = profile
    experienceLabel.text = String(profile.experience)
    //    languageLabel.text = profile.[languages]
    zommLabel.text = profile.zoom
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == K.segues.go_to_AppointmentSelectorViewController.rawValue {
      let vc = segue.destination as! AppointmentSelectorViewController
      vc.selectedProfile = selectedProfile
    }
  }
  
  func gotoChat(conversation: ConversationModel) {
    let controller = self.storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatViewController
    controller.conversation = conversation
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .flipHorizontal
    self.present(controller, animated: false, completion: nil)
  }
  
  
  
  //  MARK: - IBAction
  
  @IBAction func appointmentPressed(_ sender: Any) {
    performSegue(withIdentifier: K.segues.go_to_AppointmentSelectorViewController.rawValue, sender: self)
  }
  
  @IBAction func chatPressed(_ sender: Any) {
    
    FirestoreRepository.shared.read(collection: K.collections.conversations.rawValue, field: "usersIDs", valueAny: [user.id]) { (items: [ConversationModel]) in
      for item in items {
        if item.users.contains(where: { $0.id == self.selectedProfile!.id }) {
          self.gotoChat(conversation: item)
          return
        }
      }
      
      var conversation = ConversationModel(messages: [],
                                           usersIDs: [user.id, self.selectedProfile!.id],
                                           users: [
                                            ConversationUser(id: user.id,
                                                             name: patientProfile.nickname,
                                                             imageURL: patientProfile.imageURL),
                                            ConversationUser(id: self.selectedProfile!.id,
                                                             name: self.selectedProfile!.firstName,
                                                             imageURL: self.selectedProfile!.imageURL)
                                           ])
      
      FirestoreRepository.shared.create(collection: K.collections.conversations.rawValue, document: conversation) { docID in
        conversation.docID = docID
        self.gotoChat(conversation: conversation)
      }
    }
  }
}
