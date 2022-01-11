//
//  DoctorProfileDetailsViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase

class DoctorProfileDetailsViewController: UIViewController {
  
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var providesAdviceLabel: UILabel!
  @IBOutlet weak var experienceLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var zommLabel: UILabel!
  
  
  
  
  var selectedProfile: DoctorModel?
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    
    imageView.layer.cornerRadius = imageView.frame.size.height / 2
    imageView.clipsToBounds = true
    
    if !selectedProfile!.imageURL.isEmpty {
      let ref = Storage.storage().reference(forURL: selectedProfile!.imageURL)
          ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print(error.localizedDescription)
              } else if let data = data, let image = UIImage(data: data) {
                self.imageView.image = image
              }
          }
    }
  }
  
  @IBAction func closeAction(_ sender: Any) {
  dismiss(animated: true, completion: nil)
  }
  
  
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
    if segue.identifier == "appointmentSelect" {
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
  
  @IBAction func appointmentAction(_ sender: Any) {
    performSegue(withIdentifier: "appointmentSelect", sender: self)
  }
  
  @IBAction func chatAction(_ sender: Any) {
    
    let db = Firestore.firestore()
    db.collection("conversations").whereField("usersIDs", arrayContainsAny: [user.id]).getDocuments { snapshot, error in
      guard let docs = snapshot?.documents else {
        print("no conversations")
        return
      }
      for doc in docs {
        do {
          let conversation = try doc.data(as: ConversationModel.self)!
          if conversation.users.contains(where: { $0.id == self.selectedProfile!.id }) {
            self.gotoChat(conversation: conversation)
            return
          }
        } catch {
          fatalError()
        }
      }
      // create new conversation
      var conversation = ConversationModel(messages: [], usersIDs: [user.id, self.selectedProfile!.id], users: [ConversationUser(id: user.id, name: patientProfile.nickname), ConversationUser(id: self.selectedProfile!.id, name: self.selectedProfile!.firstName)])
      do {
        var ref: DocumentReference!
        ref = try db.collection("conversations").addDocument(from: conversation) { error in
          if let error = error {
            fatalError()
          }
          conversation.docID = ref.documentID
          self.gotoChat(conversation: conversation)
        }
      } catch {
        fatalError()
      }
      
      
      // sort convesation by last message sentAt
      //self.messages.sort(by: { $0.sentAt > $1.sentAt })
      //self.tableView.reloadData()
      
    }
    
    
    // go to chat view controller
    // send doctor profile to chat vc
    //
  }
}
