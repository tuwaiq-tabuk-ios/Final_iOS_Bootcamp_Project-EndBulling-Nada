//
//  DoctorProfileDetailsViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase

class PatientProfileDetailsViewController: UIViewController {
  
 
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateOfbirthLabel: UILabel!
  @IBOutlet weak var descriptionField: UITextView!
  
  var selectedProfile: PatientModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  
  func gotoChat(conversation: ConversationModel) {
    let controller = self.storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatViewController
    controller.conversation = conversation
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .flipHorizontal
    self.present(controller, animated: false, completion: nil)
  }
  
//  @IBAction func chatAction(_ sender: Any) {
//
//    let db = Firestore.firestore()
//    db.collection("conversations").whereField("usersIDs", arrayContainsAny: [user.id]).getDocuments { snapshot, error in
//      guard let docs = snapshot?.documents else {
//        print("no conversations")
//        return
//      }
//      for doc in docs {
//        do {
//          let conversation = try doc.data(as: ConversationModel.self)!
//          if conversation.users.contains(where: { $0.id == self.selectedProfile!.id }) {
//            self.gotoChat(conversation: conversation)
//            return
//          }
//        } catch {
//          fatalError()
//        }
//      }
//      // create new conversation
//      var conversation = ConversationModel(messages: [], usersIDs: [user.id, self.selectedProfile!.id], users: [ConversationUser(id: user.id, name: patientProfile.nickname), ConversationUser(id: self.selectedProfile!.id, name: self.selectedProfile!.firstName)])
//      do {
//        var ref: DocumentReference!
//        ref = try db.collection("conversations").addDocument(from: conversation) { error in
//          if let error = error {
//            fatalError()
//          }
//          conversation.docID = ref.documentID
//          self.gotoChat(conversation: conversation)
//        }
//      } catch {
//        fatalError()
//      }
//
//
//      // sort convesation by last message sentAt
//      //self.messages.sort(by: { $0.sentAt > $1.sentAt })
//      //self.tableView.reloadData()
//
//    }
//
//
//    // go to chat view controller
//    // send doctor profile to chat vc
//    //
//  }
}
